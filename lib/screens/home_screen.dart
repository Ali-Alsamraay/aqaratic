import 'package:aqaratak/models/property.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:aqaratak/widgets/Unit_Item.dart';
import 'package:aqaratak/widgets/categories_bar.dart';
import 'package:aqaratak/widgets/header_title.dart';
import 'package:aqaratak/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/Title_Builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String screenName = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController? scrollController = ScrollController();

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    scrollController!.addListener(() {
      if (scrollController!.position.pixels >=
              scrollController!.position.maxScrollExtent &&
          !propertiesProvider.getting_more_data!) {
        propertiesProvider.get_more_properties_with_categories();
      }
    });
  }

  @override
  Widget build(BuildContext context) => Container(
        height: 100.0.h,
        width: 100.0.w,
        color: Color(0xe8e8e8),
        child: FutureBuilder(
            future: Provider.of<PropertiesProvider>(
              context,
              listen: false,
            ).get_properties_with_categories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: TitleBuilder(
                      title: "حدث خطأ غير متوقع",
                    ),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SafeArea(
                    child: Container(
                      color: Color(0xe8e8e8),
                      width: 93.0.w,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.0.h,
                            child: HeaderTitle(),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          SizedBox(
                            height: 7.0.h,
                            child: SearchBar(),
                          ),
                          SizedBox(
                            height: 3.0.h,
                          ),
                          SizedBox(
                            child: CategoriesBar(),
                            height: 15.0.h,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          SizedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 4.0.w,
                              ),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  'أحدث العروض',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 10.0.sp,
                                    color: Color.fromARGB(
                                      176,
                                      0,
                                      0,
                                      0,
                                    ),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Expanded(
                            child: Consumer<PropertiesProvider>(
                              builder: (
                                context,
                                propertiesProviderData,
                                child,
                              ) =>
                                  ListView.builder(
                                controller: scrollController!,
                                itemCount: propertiesProviderData
                                    .filteredProperties.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UnitDetailsScreen(),
                                        ),
                                      );
                                    },
                                    child:
                                        ChangeNotifierProvider<Property>.value(
                                      value: propertiesProviderData
                                          .filteredProperties[index],
                                      child: UnitItem(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return AlertDialog(
                  content: Text(
                    'State: ${snapshot.connectionState}',
                  ),
                );
              }
            }),
      );
}
