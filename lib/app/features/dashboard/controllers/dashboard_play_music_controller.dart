part of dashboard;

class DashboardPlayMusicController extends GetxController with GetTickerProviderStateMixin {
  late final AnimationController animationPausePlay;
  late final AnimationController albumRotationAnimation;
  late final AnimationController likeAnimation;
  
  final isPlaying = false.obs;
  final currentRotation = 0.0.obs;
  final albumRotation = 0.0.obs;
  final scaleAnimation = 1.0.obs;
  final isLiked = false.obs;
  final likeScale = 1.0.obs;
  
  final musicPlay = DashboardMusic(
    image: AssetImage(ImageRasterConstant.maroon5),
    title: "Memories", 
    singerName: "Maroon 5",
    duration: Duration(seconds: 221),
  );

  @override
  void onInit() {
    super.onInit();
    log("DashboardPlayMusicController initialized");
    
    // 播放/暂停按钮动画控制器
    animationPausePlay = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    // 专辑旋转动画控制器
    albumRotationAnimation = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..addListener(() {
      if(isPlaying.value) {
        albumRotation.value += 0.01;
      }
    });

    // 收藏按钮动画控制器
    likeAnimation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // 收藏按钮缩放动画
    likeAnimation.addListener(() {
      if(isLiked.value) {
        // 收藏时的弹性动画
        likeScale.value = 1.0 + 0.4 * Curves.elasticOut.transform(likeAnimation.value);
      } else {
        // 取消收藏时的缩小动画
        likeScale.value = 1.0 - 0.2 * Curves.easeOutCubic.transform(likeAnimation.value);
      }
    });
  }

  void playOrPause() {
    if (isPlaying.value) {
      _pause();
    } else {
      _play(); 
    }
  }

  void _play() {
    isPlaying.value = true;
    animationPausePlay.forward();
    albumRotationAnimation.repeat();
    log("music is playing");
  }

  void _pause() {
    isPlaying.value = false;
    animationPausePlay.reverse();
    albumRotationAnimation.stop();
    log("music is paused");
  }

  void toggleLike() {
    log("toggleLike called");
    isLiked.value = !isLiked.value;
    
    if(isLiked.value) {
      // 收藏动画
      likeScale.value = 1.4; // 放大效果
      Future.delayed(Duration(milliseconds: 150), () {
        likeScale.value = 1.0;
      });
    } else {
      // 取消收藏动画
      likeScale.value = 0.8; // 缩小效果
      Future.delayed(Duration(milliseconds: 150), () {
        likeScale.value = 1.0;
      });
    }
    log("Like status: ${isLiked.value}");
  }

  @override
  void dispose() {
    animationPausePlay.dispose();
    albumRotationAnimation.dispose();
    likeAnimation.dispose();
    super.dispose();
  }
}
