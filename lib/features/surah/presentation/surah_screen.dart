import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_const.dart';
import '../../../component/config/app_style.dart';
import 'surah_controller.dart';
import 'widget/card_surah.dart';

class SurahScreen extends GetView<SurahController> {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyle.pressedGreen,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppConst.assetBackButton,
              width: 24,
              height: 24,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            controller.title,
            style: AppStyle.bold(size: 20, textColor: Colors.white),
          ),
        ),
        body: GetBuilder<SurahController>(builder: (ctrl) {
          final isLoadingLevel = ctrl.isLoading;
          final surah = ctrl.surahIdResponse?.ayat;

          return Skeletonizer(
            enabled: isLoadingLevel,
            child: ListView.separated(
              itemCount: surah?.length ?? 5,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 20,
                );
              },
              itemBuilder: (ctx, index) {
                final ayat = surah?[index];

                return CardSurah(
                  arab: ayat?.ar ??
                      'وَاِنْ كَانَ اَصْحٰبُ الْاَيْكَةِ لَظٰلِمِيْنَۙ',
                  translate: ayat?.tr ??
                      "fawarabbika lanas-alannahum ajma'iin\u003Cstrong\u003Ea\u003C/strong\u003E",
                  idn: ayat?.idn ?? 'Allah tempat meminta segala sesuatu.',
                  numberAyat: ayat?.nomor.toString() ?? '10',
                  enabled: true,
                );
              },
            ),
          );
        }));
  }
}
