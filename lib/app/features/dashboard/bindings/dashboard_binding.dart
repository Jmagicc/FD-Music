part of dashboard;

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(DashboardPlayMusicController());
  }
}
