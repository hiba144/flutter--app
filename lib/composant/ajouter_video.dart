import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:video_player/video_player.dart';

class VideoQrCode extends StatefulWidget {
  @override
  _VideoQrCodeState createState() => _VideoQrCodeState();
}

class _VideoQrCodeState extends State<VideoQrCode> {
  String videoPath = ""; // Chemin de la vidéo
  File? _video;
  VideoPlayerController? _controller;
  bool _isUploading = false; // Variable pour gérer l'état de l'envoi

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(''); // Vide au début
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Future<void> _selectVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _controller = VideoPlayerController.file(_video!);
        _controller!.initialize().then((_) {
          setState(() {});
        });
      });
    }
  }

  Future<void> _uploadVideo(File video) async {
    setState(() {
      _isUploading = true; // Commence l'envoi
    });
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.16.1:3000/video/addvideo'), // Remplacez YOUR_BACKEND_URL par l'URL de votre backend
    );
    request.files.add(await http.MultipartFile.fromPath('video', video.path));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        // Récupération du chemin de la vidéo enregistrée
        String videoPath = responseData['video_path'];
        setState(() {
          this.videoPath = videoPath; // Mise à jour du chemin de la vidéo
        });
      } else {
        print('Failed to upload video: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading video: $e');
    } finally {
      setState(() {
        _isUploading = false; // Fin de l'envoi
      });
    }
  }

  Future<void> _printQrCode() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vidéo et QR Code'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: _selectVideo,
                child: Text('Sélectionner Vidéo'),
              ),
            ),
            if (_video != null && _controller != null)
              Padding(
                padding: EdgeInsets.all(20.0),
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: VideoPlayer(_controller!),
                ),
              ),
            if (_video != null && !_isUploading)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_video != null) {
                      _uploadVideo(_video!);
                    }
                  },
                  child: Text('Enregistrer Vidéo'),
                ),
              ),
            if (_isUploading)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: LinearProgressIndicator(),
              ),
            if (videoPath.isNotEmpty)
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    QrImage(
                      data:
                          videoPath, // Affichage du chemin de la vidéo sous forme de QR code
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _printQrCode,
                      child: Text('Imprimer QR Code'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
