import 'package:get/get.dart';

import '../../../component/config/app_const.dart';
import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../model/list_surah_response.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;

  List<ListSurahResponse>? listSurah;
  bool isLoading = true;
  HomeState state = HomeIdle();

  HomeController(this._repository);

  @override
  void onInit() {
    getListSurah();
    super.onInit();
  }

  String backgroundCard(String name) {
    switch (name) {
      case "madinah":
        return AppConst.assetImageElementaryLearn;
      default:
        return AppConst.assetImageBeginnerLearn;
    }
  }

  Future<void> getListSurah() async {
    isLoading = true;
    state = HomeLoading();
    _repository.getListSurah(
      response: ResponseHandler(onSuccess: (data) async {
        if (data.isNotEmpty) {
          state = HomeSuccess(data);
          listSurah = data;
        } else {
          state = HomeEmpty();
        }
      }, onFailed: (responseError, message) async {
        state = HomeError();

        AlertModel.showAlert(
          title: "Error",
          message: message,
        );
      }, onDone: () {
        isLoading = false;
        update();
      }),
    );
  }
}
