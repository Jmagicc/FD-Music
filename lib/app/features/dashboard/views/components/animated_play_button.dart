import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:music_app/app/features/dashboard/views/screen/dashboard_screen.dart';

class AnimatedPlayButton extends GetView<DashboardPlayMusicController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.playOrPause,
      child: AnimatedBuilder(
        animation: controller.animationPausePlay,
        builder: (context, _) {
          return Transform.scale(
            scale: controller.scaleAnimation.value,
            child: Transform.rotate(
              angle: controller.currentRotation.value,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                child: Obx(() => Icon(
                  controller.isPlaying.value 
                    ? Icons.pause 
                    : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                )),
              ),
            ),
          );
        },
      ),
    );
  }
} 