import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? cameraController;
  XFile? photoImage;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      final cameraDescription = cameras.first;
      cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.high,
      );
      cameraController?.initialize().then((_) {
        // Additional initialization logic if needed
        setState(() {}); // Trigger a rebuild when initialization is complete
      });
    });
  }

  Future<void> takePicture() async {
    if (cameraController != null && cameraController!.value.isInitialized) {
      final Directory extDir = await getTemporaryDirectory();
      final String dirPath = '${extDir.path}/images/';
      await Directory(dirPath).create(recursive: true);

      try {
        final image = await cameraController!.takePicture();
        setState(() {
          photoImage = image;
        });
      } catch (e) {
        debugPrint('Error taking picture: $e');
      }
    }
  }

  void switchCamera() {
    if (cameras.isNotEmpty) {
      final currentCameraIndex = cameras.indexOf(cameraController!.description);
      final newCameraIndex = (currentCameraIndex + 1) % cameras.length;
      final newCameraDescription = cameras[newCameraIndex];

      cameraController!.dispose(); // Dispose the current camera
      cameraController = CameraController(
        newCameraDescription,
        ResolutionPreset.high,
      );

      cameraController?.initialize().then((_) {
        setState(() {}); // Trigger a rebuild when initialization is complete
      });
    }
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController != null) {
      return Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(18),
              ),
              child: cameraController!.value.isInitialized
                  ? CameraPreview(cameraController!)
                  : const SizedBox.shrink(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight - 12),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(
                  Icons.clear,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: kToolbarHeight),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.photo,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await takePicture();
                        if (mounted) {
                          context.pop(photoImage);
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                        child: const CircleAvatar(
                          radius: 28.0,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed: () {
                          switchCamera();
                        },
                        icon: const Icon(
                          Icons.cached,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
