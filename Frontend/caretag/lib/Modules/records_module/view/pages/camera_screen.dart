import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; // Add this to pubspec.yaml

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isInitialized = false;
  bool _isAuto = true;
  FlashMode _flashMode = FlashMode.off;
  int _capturedCount = 0;
  Color frameBoderColor = Color(0xff0D7FF2);
  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) return;

    _controller = CameraController(
      _cameras![0],
      ResolutionPreset.max,
      enableAudio: false,
    );

    await _controller!.initialize();
    if (mounted) setState(() => _isInitialized = true);
  }

  void _toggleFlash() async {
    if (!_isInitialized) return;
    setState(() {
      _flashMode = _flashMode == FlashMode.off
          ? FlashMode.torch
          : FlashMode.off;
    });
    await _controller!.setFlashMode(_flashMode);
  }

  void _takePicture() async {
    if (!_isInitialized || _controller!.value.isTakingPicture) return;
    try {
      final XFile image = await _controller!.takePicture();
      setState(() => _capturedCount++);
      debugPrint("Saved to: ${image.path}");
      // In a real app, navigate to a preview/upload screen here
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void _openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      debugPrint("Selected from gallery: ${image.path}");
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) return const Scaffold(backgroundColor: Colors.black);
    const Color containerShawdowColor = Color.fromRGBO(0, 0, 0, 0.1);
    const Color dotColor = Color(0xff0D7FF2);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(_controller!)),

          Positioned(
            left: 100,
            top: 120,
            //bottom: 650,
            child: Container(
              width: 232.55.w,
              height: 38.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999.r),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: -4,
                    color: containerShawdowColor,
                  ),
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 15,
                    spreadRadius: -3,
                    color: containerShawdowColor,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 8.h,
                    width: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dotColor,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Hold steady... Scanning",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(child: Image.asset("assets/images/records/Scanner Frame.png")),

          // 3. Top Bar (Close, Toggle, Flash)
          _buildTopBar(),

          // 4. Bottom Bar (Gallery, Shutter, Counter)
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _circleButton(Icons.close, () => Navigator.pop(context)),

            // Auto/Manual Toggle
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  _toggleLabel(
                    "Auto",
                    _isAuto,
                    () => setState(() => _isAuto = true),
                  ),
                  _toggleLabel(
                    "Manual",
                    !_isAuto,
                    () => setState(() => _isAuto = false),
                  ),
                ],
              ),
            ),

            _circleButton(
              _flashMode == FlashMode.torch ? Icons.flash_on : Icons.flash_off,
              _toggleFlash,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Gallery Button
          _circleButton(Icons.photo_library_outlined, _openGallery, size: 50),

          // Shutter Button
          GestureDetector(
            onTap: _takePicture,
            child: SvgPicture.asset("assets/images/records/button.svg"),
          ),

          Stack(
            alignment: Alignment.topRight,
            children: [
              _circleButton(Icons.description_outlined, () {}, size: 50),
              if (_capturedCount > 0)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.blue,
                  child: Text(
                    "$_capturedCount",
                    style: const TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toggleLabel(String text, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.white38,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap, {double size = 40}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: const BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: size * 0.5),
      ),
    );
  }
}
