import 'package:aqaratak/helper/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RawMaterialButton(
              elevation: 0.0,
              onPressed: () => Navigator.of(context).pop(),
              fillColor: Colors.white,
              padding: const EdgeInsets.only(right: 10),
              shape: const CircleBorder(),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Text('من نحن',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      color: Color(0xffb78457),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: -0.45,
                    )),
              ),
              SizedBox(
                height: 250,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 112,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                        child: Text(
                      "عقاراتى",
                      style: const TextStyle(
                          color: const Color(0xffb7865a),
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                          fontSize: 12.0),
                    )),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Container(
                    width: 34,
                    height: 36,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31)),
                    child: Icon(
                      EvaIcons.google,
                      color: accentColorBrown,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 34,
                    height: 36,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31)),
                    child: Icon(
                      EvaIcons.twitter,
                      color: accentColorBrown,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 34,
                    height: 36,
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31)),
                    child: Icon(
                      EvaIcons.facebook,
                      color: accentColorBrown,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text('أهدافنا'),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'تسعى المنصة العقارية إلى إنشاء سوق عقاري إلكتروني يسهل عمليات البيع والشراء واالستئجار للمنتجات العقارية، عبر تقديم معلومات شاملة عن المدينة والحي باالستعانة بالخرائط وآراء السكان والتوصيات والتقييمات في مختلف مناطق المملكة'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text('تطبيق عقاراتي'),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'تعمل المنصة العقارية على عرض كافة المخططات وبيانات قطع األراضي وأبعادها والبيانات المرتبطة بها، باستخدام البيانات ذات الكفاءة العالية والمهيكلة باستخدام أدوات الذكاء االصطناعي، وتتداخل بشكل مباشر مع حياة السكان في األحياء المختلفة وتتفاعل معهم في عمليات التنقل ومختلف أنشطة حياتهم، من تعليم، أعمال، محالت تجارية وغيرها'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
