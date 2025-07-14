import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class AdminQRScanScreen extends StatefulWidget {
  const AdminQRScanScreen({super.key});

  @override
  State<AdminQRScanScreen> createState() => _AdminQRScanScreenState();
}

class _AdminQRScanScreenState extends State<AdminQRScanScreen> {
  String? _scanResult;
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              if (barcode.rawValue == null) return;
              setState(() => _scanResult = barcode.rawValue);

              // Optionally pause scanning after first read
              _controller.stop();

              // TODO: navigate or validate here
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (_) => SomeValidationScreen(data: _scanResult!)));
            },
          ),
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
              ),
            ),
          ),
          // Torch toggle
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: GestureDetector(
              onTap: _controller.toggleTorch,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ValueListenableBuilder(
                  valueListenable: _controller.torchState,
                  builder: (context, state, child) => Icon(
                    state == TorchState.off ? Icons.flash_off : Icons.flash_on,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
          if (_scanResult != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Colors.white,
                child: Text(
                  'Scanned: $_scanResult',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'Mallanna'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}