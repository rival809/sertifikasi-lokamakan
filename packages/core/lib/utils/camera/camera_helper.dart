import 'package:core/core.dart';

class CameraHelper {
  CameraController? cameraController;

  Future<void> initializeCamera(CameraDescription camera) async {
    cameraController = CameraController(
      camera,
      ResolutionPreset.medium,
      enableAudio: false, // Nonaktifkan audio jika hanya ingin mengambil gambar
    );

    try {
      await cameraController!.initialize();
    } catch (e) {
      showInfoDialog("Error saat menginisialisasi kamera: $e");
    }
  }

  Future<XFile?> takePicture() async {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      showInfoDialog("Kamera belum diinisialisasi.");
      return null;
    }

    try {
      return await cameraController!.takePicture();
    } catch (e) {
      showInfoDialog("Error saat mengambil gambar: $e");
      return null;
    }
  }

  /// Hentikan kamera
  Future<void> disposeCamera() async {
    await cameraController?.dispose();
    cameraController = null;
  }
}
