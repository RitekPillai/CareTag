import 'dart:async';
import 'package:flutter/material.dart';

import 'package:stomp_dart_client/stomp_dart_client.dart';

import 'dart:convert';

enum ScanState {
  idle,
  demo,
  qr,
  nfc,
  manual,
  detected,
  loading,
  creating,
  session,
  redirecting,
  mismatch,
  waiting,
  accepted,
  rejected,
}

class ScanCareTagPage extends StatefulWidget {
  final String? expectedCaretagId;
  final String? expectedPatientName;
  final String? expectedPatientId;

  const ScanCareTagPage({
    super.key,
    this.expectedCaretagId,
    this.expectedPatientName,
    this.expectedPatientId,
  });

  @override
  State<ScanCareTagPage> createState() => _ScanCareTagPageState();
}

class _ScanCareTagPageState extends State<ScanCareTagPage> {
  ScanState _scanState = ScanState.idle;
  int _demoTimer = 5;
  Timer? _demoTimerRef;
  StompClient? _stompClient;
  bool _processing = false;
  late String? _scanError;

  @override
  void initState() {
    super.initState();
    if (widget.expectedCaretagId == null) {
      setState(() => _scanState = ScanState.demo);
      _startDemoTimer();
    }
  }

  @override
  void dispose() {
    _demoTimerRef?.cancel();
    _stompClient?.deactivate();
    super.dispose();
  }

  void _startDemoTimer() {
    _demoTimer = 5;
    _demoTimerRef?.cancel();
    _demoTimerRef = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_demoTimer <= 1) {
        timer.cancel();
        setState(() => _demoTimer = 0);
        _handleDemoScanComplete();
      } else {
        setState(() => _demoTimer--);
      }
    });
  }

  void _handleDemoScanComplete() {
    // Demo mode: navigate to a dummy patient or show detected state
    setState(() => _scanState = ScanState.detected);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _scanState = ScanState.redirecting);
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  Future<void> _processScannedId(String caretagId) async {
    if (_processing) return;
    _processing = true;

    try {
      setState(() => _scanState = ScanState.loading);

      // POST to Spring backend
      // final response = await http.post(
      //   Uri.parse('https://your-backend/link/request'),
      //   headers: {'Content-Type': 'text/plain', 'Authorization': 'Bearer $token'},
      //   body: caretagId,
      // );
      // final docId = jsonDecode(response.body)['docId'];

      setState(() => _scanState = ScanState.waiting);

      final token = 'YOUR_TOKEN'; // Retrieve from storage
      _stompClient = StompClient(
        config: StompConfig(
          url:
              'wss://uncatastrophic-nonobserving-marylyn.ngrok-free.dev/websocket/websocket',
          stompConnectHeaders: {'Authorization': 'Bearer $token'},
          onConnect: (StompFrame frame) {
            _stompClient?.subscribe(
              destination: '/user/queue/approval',
              callback: (StompFrame msg) {
                final data = jsonDecode(msg.body ?? '{}');
                if (data['status'] == 'APPROVED') {
                  setState(() => _scanState = ScanState.accepted);
                  Future.delayed(const Duration(seconds: 2), () {
                    _stompClient?.deactivate();
                    if (mounted) {
                      Navigator.of(context).pushReplacementNamed(
                        '/patients/${data['patientId'] ?? widget.expectedPatientId ?? ''}',
                      );
                    }
                  });
                } else if (data['status'] == 'DENIED') {
                  setState(() => _scanState = ScanState.rejected);
                  _stompClient?.deactivate();
                }
              },
            );
          },
          onWebSocketError: (dynamic error) {
            setState(() {
              _scanError = 'WebSocket error: $error';
              _scanState = ScanState.idle;
            });
          },
        ),
      );
      _stompClient?.activate();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Scan failed: $e')));
      setState(() => _scanState = ScanState.idle);
    } finally {
      _processing = false;
    }
  }

  void _handleStopScan() {
    _demoTimerRef?.cancel();
    setState(() {
      _scanState = ScanState.idle;
      _demoTimer = 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _buildScanStateContent(),
            ),
          ),
          Positioned(
            top: 48,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                _handleStopScan();
                Navigator.of(context).pop();
              },
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanStateContent() {
    switch (_scanState) {
      case ScanState.demo:
        return _buildDemoState();
      case ScanState.idle:
        return _buildIdleState();
      case ScanState.waiting:
        return _buildWaitingState();
      case ScanState.accepted:
        return _buildAcceptedState();
      case ScanState.rejected:
        return _buildRejectedState();
      case ScanState.loading:
        return _buildLoadingState();
      case ScanState.detected:
        return _buildDetectedState();
      case ScanState.redirecting:
        return _buildRedirectingState();
      default:
        return _buildIdleState();
    }
  }

  Widget _buildDemoState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 112,
              height: 112,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
            Text(
              '$_demoTimer',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(value: (5 - _demoTimer) / 5),
        const SizedBox(height: 16),
        const Text(
          'Scanning CareTag...',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        const Text(
          'Reading patient information',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: _handleStopScan,
          icon: const Icon(Icons.close),
          label: const Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildIdleState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.smartphone, size: 80, color: Theme.of(context).primaryColor),
        const SizedBox(height: 24),
        if (widget.expectedPatientName != null) ...[
          const Text(
            'Verify Patient',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    widget.expectedPatientName!,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    widget.expectedCaretagId ?? '',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          const Text(
            'Ready to Scan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap a CareTag or enter ID manually',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
        const SizedBox(height: 24),
        if (widget.expectedCaretagId == null)
          ElevatedButton.icon(
            onPressed: () {
              setState(() => _scanState = ScanState.demo);
              _startDemoTimer();
            },
            icon: const Icon(Icons.timer),
            label: const Text('Demo Scan (5s)'),
          ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: () async {
            final id = await _showManualEntryDialog();
            if (id != null && id.isNotEmpty) _processScannedId(id);
          },
          icon: const Icon(Icons.keyboard),
          label: const Text('Enter ID manually'),
        ),
      ],
    );
  }

  Widget _buildWaitingState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 24),
        const Text(
          'Awaiting Consent...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'The patient must tap "Accept" on their phone.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            _stompClient?.deactivate();
            setState(() => _scanState = ScanState.idle);
          },
          child: const Text('Cancel Request'),
        ),
      ],
    );
  }

  Widget _buildAcceptedState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 80),
        const SizedBox(height: 16),
        const Text(
          'Access Accepted',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "You can now access the patient's record.",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => Navigator.of(
            context,
          ).pushReplacementNamed('/patients/${widget.expectedPatientId ?? ''}'),
          child: const Text('Go to Patient Record'),
        ),
      ],
    );
  }

  Widget _buildRejectedState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cancel, color: Colors.red, size: 80),
        const SizedBox(height: 16),
        const Text(
          'Access Rejected',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Patient denied the request.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => setState(() => _scanState = ScanState.idle),
          child: const Text('Back to Scan'),
        ),
      ],
    );
  }

  Widget _buildDetectedState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, color: Colors.green, size: 80),
        SizedBox(height: 16),
        Text(
          'Tag Detected',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text('Loading...', style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildRedirectingState() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text(
          'Opening Patient Record...',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Future<String?> _showManualEntryDialog() async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter CareTag ID'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'e.g. CT-2026-1234'),
          textCapitalization: TextCapitalization.characters,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pop(ctx, controller.text.trim().toUpperCase()),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
