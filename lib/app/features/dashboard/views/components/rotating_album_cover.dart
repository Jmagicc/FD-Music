import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/app/features/dashboard/views/screen/dashboard_screen.dart';

class RotatingAlbumCover extends GetView<DashboardPlayMusicController> {
  final double size;
  
  const RotatingAlbumCover({
    Key? key,
    this.size = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller.albumRotationAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: controller.albumRotation.value,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipOval(
              child: Image(
                image: controller.musicPlay.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
} 