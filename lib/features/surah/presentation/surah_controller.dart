import 'package:get/get.dart';

import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../model/surah_by_id_response.dart';
import '../repository/surah_repository.dart';
import 'surah_state.dart';

class SurahController extends GetxController {
  final SurahRepository _repository;
  bool isLoading = true;
  SurahState state = SurahIdle();
  String title = "";
  int surahId = 0;
  SurahByIdResponse? surahIdResponse;

  SurahController(this._repository);

  @override
  void onInit() {
    super.onInit();
    title = Get.arguments['title'];
    surahId = Get.arguments['surah_id'];

    getSurah();
  }

  Future<void> getSurah() async {
    isLoading = true;
    state = SurahLoading();
    _repository.getListSurah(
        nomor: surahId,
        response: ResponseHandler(onSuccess: (data) async {
          surahIdResponse = data;
        }, onFailed: (responseError, message) async {
          state = SurahError();

          AlertModel.showAlert(
            title: "Error",
            message: message,
          );
        }, onDone: () {
          isLoading = false;
          update();
        }));
  }
}
