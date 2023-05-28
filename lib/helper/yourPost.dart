import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';
import '../utils/widgets.dart';

Widget yourPost(double w, double h, String title, String image, String topic, int readMinute, String publishedAt) {
  return Container(
    width: w,
    height: h * 0.14,
    margin: const EdgeInsets.all(8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        color: themeColorWhite,
        borderRadius: BorderRadius.circular(10.0)
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                alignment: Alignment.topLeft,
                child: overFlowText(title, 17, FontWeight.w500, themeColorBlack,
                    TextDecoration.none, TextAlign.justify, 3, TextOverflow.ellipsis),
              ),
            ),
            const Expanded(flex: 1, child: SizedBox()),
            Expanded(
              flex: 2,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(color: image == "" ?
                    themeColorWhite : themeColorGreen),
                    borderRadius: BorderRadius.circular(2.0)
                ),
                child: image == "" ?
                SvgPicture.asset("assets/images/empty_cover_image.svg")
                    : Image.network(image),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      gradient: appBodyGradient()
                  ),
                  alignment: Alignment.center,
                  child: text(topic, 14, FontWeight.w400,
                      themeColorWhite, TextDecoration.none, TextAlign.center)
                ),
                const SizedBox(width: 3.0,),
                text("$readMinute min read", 14, FontWeight.w400,
                    themeColorBlack, TextDecoration.none, TextAlign.center)
              ],
            ),
            text(DateFormat("dd MMMM yyyy").format(DateFormat("yyyy-MM-dd'T'HH:mm:ss")
                .parse(publishedAt)),
                14, FontWeight.w400, themeColorBlack, TextDecoration.none, TextAlign.center)
          ],
        )
      ],
    ),
  );
}