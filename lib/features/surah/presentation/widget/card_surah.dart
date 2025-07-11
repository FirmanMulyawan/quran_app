import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

import '../../../../component/config/app_const.dart';
import '../../../../component/config/app_style.dart';
// import '../../../../component/widget/custom_progress_bar.dart';

class CardSurah extends StatelessWidget {
  final String arab;
  final String translate;
  final String idn;
  final String numberAyat;
  final bool enabled;

  const CardSurah({
    super.key,
    required this.arab,
    required this.translate,
    required this.idn,
    required this.numberAyat,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = enabled ? Colors.white : Colors.grey.shade300;
    final String backgroundAsset = enabled
        ? AppConst.assetTopicBackground
        : AppConst.assetTopicDisabledBackground;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: svg_provider.Svg(
              backgroundAsset,
            ),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Opacity(
                opacity: enabled ? 1.0 : 0.4,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(numberAyat,
                          style: AppStyle.bold(
                              size: 12, textColor: AppStyle.green)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // arab and progress bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      arab,
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Html(data: translate, style: {
                      "body": Style(
                          fontFamily: "BloggerSans",
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontSize: FontSize(12))
                    }),
                    Text(idn,
                        style:
                            AppStyle.regular(size: 12, textColor: textColor)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
