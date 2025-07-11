import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_route.dart';
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
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: controller.searchController,
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onChanged: (value) {
                    // controller.updateKeyword();
                  },
                  style: AppStyle.regular(
                    size: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search Surah",
                    hintStyle: AppStyle.regular(
                      size: 20,
                      textColor: AppStyle.searchHintColor,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: AppStyle.searchBorderColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(
                        color: AppStyle.searchBorderColor,
                        width: 1.5,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppStyle.pressedGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GetBuilder<HomeController>(builder: (ctrl) {
                  final isLoadingLevel = ctrl.isLoading;
                  final listSurah = ctrl.listSurah;
                  final lastIndex = listSurah?.length ?? 0;

                  return Skeletonizer(
                    enabled: isLoadingLevel,
                    child: RefreshIndicator(
                      onRefresh: () {
                        ctrl.getListSurah();
                        return Future.value();
                      },
                      child: ListView.separated(
                          itemCount: (listSurah?.length ?? 5) + 1,
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (ctx, index) {
                            if (isLoadingLevel == false) {
                              if (index == lastIndex) {
                                return const SizedBox(height: 200);
                              }
                            }

                            final surah = listSurah?[index];

                            return _cardSurah(
                              isloading: isLoadingLevel,
                              onTap: () => Get.toNamed(AppRoute.surah,
                                  arguments: {
                                    'title': surah?.namaLatin,
                                    'surah_id': surah?.nomor
                                  }),
                              backgroundImage: ctrl.backgroundCard(
                                  surah?.tempatTurun ?? "madinah"),
                              surahName: surah?.nama ?? "Nama Surah",
                              namaLatin: surah?.namaLatin ?? "Nama Latin",
                              arti: surah?.arti ?? "Pembukaan",
                              jumlahAyat: surah?.jumlahAyat ?? 0,
                              tempatTurun: surah?.tempatTurun ?? "madinah",
                              deskripsi: surah?.deskripsi ?? '',
                              hoverColor:
                                  listSurah?[index].tempatTurun == "madinah"
                                      ? AppStyle.pressedGreen
                                      : AppStyle.hoverBlue,
                              mainColor:
                                  listSurah?[index].tempatTurun == "madinah"
                                      ? AppStyle.green
                                      : AppStyle.mainBlue,
                            );
                          }),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  Widget _cardSurah(
      {void Function()? onTap,
      String backgroundImage = '',
      String surahName = '',
      String namaLatin = '',
      String arti = '',
      int jumlahAyat = 0,
      String tempatTurun = '',
      String deskripsi = '',
      Color? hoverColor,
      Color? mainColor,
      bool isloading = true}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundImage), fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              surahName,
                              style: AppStyle.bold(
                                  textColor: AppStyle.whiteColor, size: 20),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Wrap(
                              children: [
                                Text(
                                  namaLatin,
                                  style: AppStyle.medium(
                                          textColor: Colors.white)
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 1,
                                  height: 13,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                Text(
                                  arti,
                                  style: AppStyle.medium(
                                          textColor: Colors.white)
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  "$jumlahAyat Ayat",
                                  style: AppStyle.medium(
                                          textColor: Colors.white)
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Container(
                                  width: 1,
                                  height: 13,
                                  color: Colors.white,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                ),
                                Text(
                                  tempatTurun,
                                  style: AppStyle.medium(
                                          textColor: Colors.white)
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 130,
                              child: isloading == false
                                  ? PopupButton(
                                      onPressed: () async {
                                        final result =
                                            await AlertModel.showConfirmation(
                                          barrierDismissible: false,
                                          title: "Deskripsi",
                                          message: deskripsi,
                                          hoverColor:
                                              hoverColor ?? AppStyle.hoverBlue,
                                          mainColor:
                                              mainColor ?? AppStyle.mainBlue,
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
                                    )
                                  : Container(
                                      width: 20,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
