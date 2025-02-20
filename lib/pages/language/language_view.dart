import "package:eva_icons_flutter/eva_icons_flutter.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:openim_common/openim_common.dart";

import "language_logic.dart";

class LanguagePage extends StatelessWidget {
  LanguagePage({super.key});

  final logic = Get.find<LanguageLogic>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (context.t.languageSetup).toText..style = Styles.ts_0C1C33_17_semibold,
        ),
        body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 16.w),
          itemCount: logic.sortedLanguageList.length,
          itemBuilder: (context, index) {
            final language = logic.sortedLanguageList[index];
            return Obx(() => _buildItemView(
                  logic.getTranslatedBaseLanguage(language),
                  onSelect: () => logic.onSelectLanguage(language),
                  isSelect: logic.isCurrentLanguage(language),
                ));
          },
        ));
  }

  InkWell _buildItemView(String text,
      {VoidCallback? onSelect, required bool isSelect}) {
    return InkWell(
      onTap: onSelect,
      splashColor: Styles.c_0089FF.withOpacity(0.05),
      highlightColor: Styles.c_0089FF.withOpacity(0.05),
      child: Container(
        height: 48.h,
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Styles.c_EDEDED,
              width: 1,
            ),
          ),
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: 24.w,
            children: [
              SizedBox(
                width: constraints.maxWidth * 0.8,
                child: text.toText
                  ..style = isSelect
                      ? Styles.ts_0089FF_14_medium
                      : Styles.ts_666666_14
                  ..overflow = TextOverflow.ellipsis,
              ),
              Visibility(
                visible: isSelect,
                child: Icon(EvaIcons.checkmarkCircle2Outline,
                    color: Styles.c_0089FF, size: 22.r),
              ),
            ],
          );
        }),
      ),
    );
  }
}
