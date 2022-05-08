import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';

final listPagesViewModel = [
  PageViewModel(
    title: "",
    bodyWidget: Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: SvgPicture.asset('assets/images/intro1.svg',
              height: 240.0, width: 240.0, semanticsLabel: ''),
        ),
        const SizedBox(
          height: 80,
        ),
        Text("خدمات عقارية",
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: Color(0xffb78457),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 33.0),
            ),
            textAlign: TextAlign.left),
        // const Padding(
        //   padding: EdgeInsets.all(15.0),
        //   child: Text("هناك حقيقة مثبتة منذ زمن طويل وهي\n أن المحتوى المقروء لصفحة ما \n\n",
        //       style: TextStyle(
        //         fontFamily: 'Sukar',
        //         color: Color(0xffffffff),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w700,
        //         fontStyle: FontStyle.normal,
        //       )
        //   ),
        // ),
      ],
    ),
  ),
  PageViewModel(
    title: "",
    bodyWidget: Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        SvgPicture.asset('assets/images/intro2.svg',
            height: 240.0, width: 240.0, semanticsLabel: ''),
        const SizedBox(
          height: 80,
        ),
        Text("بحث إحترافي",
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: Color(0xffb78457),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 33.0),
            ),
            textAlign: TextAlign.left),
        // const Padding(
        //   padding: EdgeInsets.all(15.0),
        //   child: Text("هناك حقيقة مثبتة منذ زمن طويل وهي\n أن المحتوى المقروء لصفحة ما \n\n",
        //       style: TextStyle(
        //         fontFamily: 'Sukar',
        //         color: Color(0xffffffff),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w700,
        //         fontStyle: FontStyle.normal,
        //       )
        //   ),
        // ),
      ],
    ),
  ),
  PageViewModel(
    title: "",
    bodyWidget: Column(
      children: [
        const SizedBox(
          height: 200,
        ),
        SvgPicture.asset('assets/images/intro3.svg',
            height: 240.0, width: 240.0, semanticsLabel: ''),
        const SizedBox(
          height: 80,
        ),
        Text("إعلن عن عقارك",
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: Color(0xffb78457),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  fontSize: 33.0),
            ),
            textAlign: TextAlign.left),
        // const Padding(
        //   padding: EdgeInsets.all(15.0),
        //   child: Text("هناك حقيقة مثبتة منذ زمن طويل وهي\n أن المحتوى المقروء لصفحة ما \n\n",
        //       style: TextStyle(
        //         fontFamily: 'Sukar',
        //         color: Color(0xffffffff),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w700,
        //         fontStyle: FontStyle.normal,
        //       )
        //   ),
        // ),
      ],
    ),
  ),
];
