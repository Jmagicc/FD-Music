part of dashboard;

class _BottomNavbar extends GetView<DashboardPlayMusicController> {
  _BottomNavbar({Key? key}) : super(key: key);

  final _sliderValue = 0.6.obs;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (Responsive.isMobile(context)) ? 80 : 120,
      child: Material(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        elevation: 10,
        shadowColor: Colors.black26,
        color: Colors.white,
        child: (Responsive.isMobile(context))
            ? _mobileNavbar()
            : Row(
                children: [
                  Flexible(flex: 1, child: _label()),
                  Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          _button(),
                          _slider(),
                        ],
                      )),
                  Flexible(flex: 1, child: _actionsButton()),
                ],
              ),
      ),
    );
  }

  Widget _mobileNavbar() {
    return InkWell(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
      onTap: () => showBottomSheetDetailSong(),
      child: Row(
        children: [
          Flexible(flex: 1, child: _label()),
          Flexible(
            flex: 1,
            child: _button(),
          ),
        ],
      ),
    );
  }

  Widget _label() {
    return Row(
      children: [
        SizedBox(width: 20),
        RotatingAlbumCover(size: 60),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.musicPlay.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Text(
                controller.musicPlay.singerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget _button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          iconSize: 30,
          icon: Icon(Icons.fast_rewind_outlined),
          onPressed: () {},
          tooltip: "previous song",
        ),
        AnimatedPlayButton(),
        IconButton(
          iconSize: 30,
          icon: Icon(Icons.fast_forward_outlined),
          onPressed: () {},
          tooltip: "next song",
        ),
      ],
    );
  }

  Widget _slider() {
    return Row(
      children: [
        Obx(() => Text(Duration(
          seconds: (controller.musicPlay.duration.inSeconds * _sliderValue.value).toInt()
        ).formatMS())),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(Get.context!).copyWith(
              thumbColor: Colors.transparent,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0)
            ),
            child: Obx(() => Slider(
              value: _sliderValue.value,
              activeColor: Theme.of(Get.context!).primaryColor,
              onChanged: (value) => _sliderValue.value = value,
            )),
          ),
        ),
        Text(controller.musicPlay.duration.formatMS()),
      ],
    );
  }

  Widget _actionsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Spacer(flex: 5),
        Obx(() => IconButton(
          icon: SvgPicture.asset(
            controller.isLiked.value
              ? IconConstant.hearthFilled
              : IconConstant.hearth,
            color: controller.isLiked.value ? Colors.red : Colors.grey[600],
          ),
          onPressed: () => controller.toggleLike(),
          tooltip: "Liked song",
        )),
        Spacer(flex: 1),
        IconButton(
          icon: SvgPicture.asset(IconConstant.music),
          onPressed: () {},
          tooltip: "List music",
        ),
        Spacer(flex: 1),
        IconButton(
          icon: SvgPicture.asset(IconConstant.repeat),
          onPressed: () {},
          tooltip: "Repeat",
        ),
        SizedBox(width: 20),
      ],
    );
  }

  void showBottomSheetDetailSong() {
    Get.bottomSheet(
      Container(
        height: Get.height * .95,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 顶部操作栏
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_down),
                      onPressed: () => Get.back(),
                      tooltip: "Close",
                    ),
                    Row(
                      children: [
                        AnimatedLikeButton(size: 24),
                        SizedBox(width: kDefaultPadding),
                        IconButton(
                          icon: SvgPicture.asset(
                            IconConstant.music,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {},
                          tooltip: "List music",
                        ),
                        SizedBox(width: kDefaultPadding),
                        IconButton(
                          icon: SvgPicture.asset(
                            IconConstant.repeat,
                            color: Colors.grey[600],
                          ),
                          onPressed: () {},
                          tooltip: "Repeat",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // 专辑封面
              Container(
                height: Get.width * .7,
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                child: RotatingAlbumCover(size: Get.width * .7),
              ),
              
              // 歌曲信息
              Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.musicPlay.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Text(
                      controller.musicPlay.singerName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: kDefaultPadding),
                    _slider(),
                    SizedBox(height: kDefaultPadding),
                    _button(),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
