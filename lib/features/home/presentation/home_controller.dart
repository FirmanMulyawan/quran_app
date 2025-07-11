import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../component/config/app_const.dart';
import '../../../component/util/helper.dart';
import '../../../component/util/state.dart';
import '../model/list_surah_response.dart';
import '../repository/home_repository.dart';
import 'home_state.dart';

class HomeController extends GetxController {
  final HomeRepository _repository;

  List<ListSurahResponse>? listSurah;
  List<ListSurahResponse> _allSurah = [];
  bool isLoading = true;
  HomeState state = HomeIdle();
  final TextEditingController searchController = TextEditingController();
  final Debouncer _searchDebouncer =
      Debouncer(delay: const Duration(milliseconds: 500));

  HomeController(this._repository);

  @override
  void onInit() {
    getListSurah();
    searchController.addListener(() {
      final query = searchController.text;
      _searchDebouncer(() {
        onSearchChanged(query);
      });
    });
    super.onInit();
  }

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      listSurah = _allSurah;
    } else {
      listSurah = _allSurah
          .where((surah) =>
              surah.namaLatin!.toLowerCase().contains(query.toLowerCase()) ||
              surah.arti!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    update();
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
          _allSurah = data;
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
