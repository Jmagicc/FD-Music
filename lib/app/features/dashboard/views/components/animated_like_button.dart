import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:developer';
import 'package:music_app/app/constants/app_constant.dart';
import 'package:music_app/app/features/dashboard/views/screen/dashboard_screen.dart';

class AnimatedLikeButton extends GetView<DashboardPlayMusicController> {
  final double size;
  
  const AnimatedLikeButton({
    Key? key,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        log("Like button tapped");
        controller.toggleLike();
      },
      child: AnimatedBuilder(
        animation: controller.likeAnimation,
        builder: (context, _) {
          return Transform.scale(
            scale: controller.likeScale.value,
            child: Obx(() => SvgPicture.asset(
              controller.isLiked.value 
                ? IconConstant.hearthFilled
                : IconConstant.hearth,
              color: controller.isLiked.value ? Colors.red : Colors.grey[600],
              width: size,
              height: size,
            )),
          );
        },
      ),
    );
  }
} 