import 'dart:async';
import 'package:flutter/material.dart';

class Patient {
  final String id;
  final String fullName;
  final String caretagId;
  final String? emergencyContactName;
  final String? emergencyContactPhone;

  const Patient({
    required this.id,
    required this.fullName,
    required this.caretagId,
    this.emergencyContactName,
    this.emergencyContactPhone,
  });
}

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<PatientsPage> createState() => _PatientsPageState();
}

class _PatientsPageState extends State<PatientsPage> {
  String _search = '';
  String? _scanningPatientId;
  int _scanTimer = 5;
  double _scanProgress = 0;
  Timer? _scanInterval;
  bool _showActiveSessionDialog = false;

  // Replace with real data from your backend/supabase
  final List<Patient> _patients = [];
  final List<Map<String, dynamic>> _activeSessions = [];

  bool get hasActiveSession => _activeSessions.isNotEmpty;
  Map<String, dynamic>? get currentActiveSession =>
      hasActiveSession ? _activeSessions.first : null;

  List<Patient> get filteredPatients => _patients.where((p) {
    final q = _search.toLowerCase();
    return p.fullName.toLowerCase().contains(q) ||
        p.caretagId.toLowerCase().contains(q);
  }).toList();

  bool patientHasActiveSession(String patientId) =>
      _activeSessions.any((s) => s['patient_id'] == patientId);

  void _startScanTimer(String patientId) {
    setState(() {
      _scanningPatientId = patientId;
      _scanTimer = 5;
      _scanProgress = 0;
    });
    _scanInterval?.cancel();
    _scanInterval = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_scanTimer <= 1) {
        timer.cancel();
        _handleScanComplete(patientId);
      } else {
        setState(() {
          _scanTimer--;
          _scanProgress = (_scanProgress + 20).clamp(0, 100);
        });
      }
    });
  }

  void _handlePatientCardClick(String patientId, bool isActive) {
    if (isActive) {
      Navigator.of(context).pushNamed('/patients/$patientId');
      return;
    }
    if (hasActiveSession) {
      setState(() => _showActiveSessionDialog = true);
      return;
    }
    _startScanTimer(patientId);
  }

  void _handleScanButtonClick() {
    if (hasActiveSession) {
      setState(() => _showActiveSessionDialog = true);
      return;
    }
    Navigator.of(context).pushNamed('/scan');
  }

  Future<void> _handleScanComplete(String patientId) async {
    setState(() => _scanningPatientId = null);
    // Call startSession API here
    Navigator.of(context).pushNamed('/patients/$patientId');
  }

  @override
  void dispose() {
    _scanInterval?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Patients')),
      body: Column(
        children: [
          // Security Notice
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              border: Border.all(color: Colors.amber.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.shield, color: Colors.amber, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Secure Access Mode: Scan CareTag to access full patient records.',
                    style: TextStyle(color: Colors.brown, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          // Active Session Dialog
          if (_showActiveSessionDialog)
            AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.warning, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Session Already Active'),
                ],
              ),
              content: Text(
                'You have an active session with ${currentActiveSession?['patients']?['full_name'] ?? 'a patient'}. End it before starting a new one.',
              ),
              actions: [
                TextButton(
                  onPressed: () =>
                      setState(() => _showActiveSessionDialog = false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _showActiveSessionDialog = false);
                    Navigator.of(context).pushNamed(
                      '/patients/${currentActiveSession?['patient_id']}',
                    );
                  },
                  child: const Text('Go to Current Patient'),
                ),
              ],
            ),

          // Search
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search by name or CareTag ID...',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),

          // Scan CareTag Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: hasActiveSession ? null : _handleScanButtonClick,
                icon: Icon(
                  hasActiveSession ? Icons.lock : Icons.qr_code_scanner,
                ),
                label: Text(
                  hasActiveSession ? 'Session Active' : 'Scan CareTag',
                ),
              ),
            ),
          ),

          // Patient List
          Expanded(
            child: filteredPatients.isEmpty
                ? const Center(child: Text('No patients found'))
                : ListView.builder(
                    itemCount: filteredPatients.length,
                    itemBuilder: (ctx, i) {
                      final patient = filteredPatients[i];
                      final isActive = patientHasActiveSession(patient.id);
                      final isScanning = _scanningPatientId == patient.id;
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: isActive
                                ? Theme.of(
                                    context,
                                  ).primaryColor.withOpacity(0.4)
                                : isScanning
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            width: isScanning ? 2 : 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: isScanning
                              ? null
                              : () => _handlePatientCardClick(
                                  patient.id,
                                  isActive,
                                ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: isActive
                                          ? Theme.of(
                                              context,
                                            ).primaryColor.withAlpha(100)
                                          : Colors.grey.shade200,
                                      child: Text(
                                        patient.fullName
                                            .split(' ')
                                            .map((e) => e[0])
                                            .take(2)
                                            .join(),
                                        style: TextStyle(
                                          color: isActive
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            patient.fullName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            patient.caretagId,
                                            style: const TextStyle(
                                              fontFamily: 'monospace',
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isActive)
                                      const Chip(
                                        label: Text('Active'),
                                        backgroundColor: Colors.green,
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                        ),
                                      )
                                    else
                                      const Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                        size: 18,
                                      ),
                                  ],
                                ),
                                if (patient.emergencyContactName != null) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 14,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${patient.emergencyContactName}${patient.emergencyContactPhone != null ? ' (${patient.emergencyContactPhone})' : ''}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                                if (isScanning) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Scanning CareTag...',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${_scanTimer}s',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                          fontFamily: 'monospace',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  LinearProgressIndicator(
                                    value: _scanProgress / 100,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
