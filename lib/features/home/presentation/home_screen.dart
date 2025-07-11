import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_style.dart';
import '../../../component/util/helper.dart';
import '../../../component/widget/popup_button.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.whiteColor,
        body: GetBuilder<HomeController>(builder: (ctrl) {
          final isLoadingLevel = ctrl.isLoading;
          final listSurah = ctrl.listSurah;

          return Skeletonizer(
            enabled: isLoadingLevel,
            child: RefreshIndicator(
              onRefresh: () {
                ctrl.getListSurah();
                return Future.value();
              },
              child: ListView.separated(
                  itemCount: listSurah?.length ?? 5,
                  separatorBuilder: (ctx, index) {
                    return const SizedBox(
                      height: 20,
                    );
                  },
                  itemBuilder: (ctx, index) {
                    final surah = listSurah?[index];

                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(ctrl.backgroundCard(
                                surah?.tempatTurun ?? "madinah")),
                            fit: BoxFit.cover),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 100,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      surah?.nama ?? "Nama Surah",
                                      style: AppStyle.bold(
                                          textColor: AppStyle.whiteColor,
                                          size: 20),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Wrap(
                                      children: [
                                        Text(
                                          surah?.namaLatin ?? "Nama Latin",
                                          style: AppStyle.medium(
                                                  textColor: Colors.white)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 13,
                                          color: Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                        ),
                                        Text(
                                          surah?.arti ?? "Pembukaan",
                                          style: AppStyle.medium(
                                                  textColor: Colors.white)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${surah?.jumlahAyat ?? 0} Ayat",
                                          style: AppStyle.medium(
                                                  textColor: Colors.white)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                          width: 1,
                                          height: 13,
                                          color: Colors.white,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                        ),
                                        Text(
                                          surah?.tempatTurun ?? "madinah",
                                          style: AppStyle.medium(
                                                  textColor: Colors.white)
                                              .copyWith(
                                                  fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      width: 130,
                                      child: PopupButton(
                                        onPressed: () async {
                                          final result =
                                              await AlertModel.showConfirmation(
                                            barrierDismissible: false,
                                            title: "Deskripsi",
                                            message: surah?.deskripsi ?? '',
                                            hoverColor:
                                                listSurah?[index].tempatTurun ==
                                                        "madinah"
                                                    ? AppStyle.pressedGreen
                                                    : AppStyle.hoverBlue,
                                            mainColor:
                                                listSurah?[index].tempatTurun ==
                                                        "madinah"
                                                    ? AppStyle.green
                                                    : AppStyle.mainBlue,
                                          );
                                          if (result == true) {}
                                        },
                                        size: 20,
                                        color: AppStyle.mainOrange,
                                        shadowColor: AppStyle.hoverOrange,
                                        child: Text(
                                          "Deskription",
                                          textAlign: TextAlign.center,
                                          style: AppStyle.bold(
                                            size: 10,
                                            textColor: AppStyle.whiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        }));
  }
}
