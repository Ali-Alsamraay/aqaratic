import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/property.dart';
import 'package:aqaratak/providers/Properties_provider.dart';
import 'package:aqaratak/providers/main_provider.dart';
import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:aqaratak/widgets/Unit_Item.dart';
import 'package:aqaratak/widgets/categories_bar.dart';
import 'package:aqaratak/widgets/header_title.dart';
import 'package:aqaratak/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widgets/Title_Builder.dart';
import '../widgets/dropDownMenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String screenName = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController? scrollController = ScrollController();
  final ScrollController? featured_scrollController = ScrollController();

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  bool? loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await Provider.of<MainProvider>(
          context,
          listen: false,
        ).get_contracts_file();
        if (mounted)
          setState(() {
            loading = false;
          });
      } catch (e) {
        if (mounted)
          setState(() {
            loading = false;
          });
      }
    });
    final PropertiesProvider propertiesProvider =
        Provider.of<PropertiesProvider>(context, listen: false);
    scrollController!.addListener(() {
      if (scrollController!.position.pixels >=
              scrollController!.position.maxScrollExtent &&
          !propertiesProvider.getting_more_data!) {
        propertiesProvider.get_more_properties_with_categories();
      }
    });

    featured_scrollController!.addListener(() {
      if (featured_scrollController!.position.pixels >=
              featured_scrollController!.position.maxScrollExtent &&
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
        child: loading!
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : FutureBuilder(
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
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: 100.0.w,
                              height: 9.0.h,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 3.0.w,
                                  ),
                                  DropDownMenu(),
                                  SizedBox(
                                    width: 10.0.w,
                                  ),
                                  Text(
                                    "صفحة رئيسية",
                                    style: TextStyle(
                                      color: accentColorBlue,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: SingleChildScrollView(
                              child: Container(
                                color: Color(0xe8e8e8),
                                width: 100.0.w,
                                // height: 90.0.h,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15.0.h,
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
                                      height: 6.0.h,
                                    ),
                                    Label(title: "أحدث العروض"),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Consumer<PropertiesProvider>(
                                      builder: (
                                        context,
                                        propertiesProviderData,
                                        child,
                                      ) =>
                                          PropertiesListBuilder(
                                        scrollController: scrollController!,
                                        properties: propertiesProviderData
                                            .filteredProperties,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0.h,
                                    ),
                                    Label(title: "العقارات المميزة"),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    Consumer<PropertiesProvider>(
                                      builder: (
                                        context,
                                        propertiesProviderData,
                                        child,
                                      ) =>
                                          PropertiesListBuilder(
                                        scrollController:
                                            featured_scrollController!,
                                        properties:
                                            propertiesProviderData.properties
                                                .where(
                                                  (element) =>
                                                      element.is_featured == 1,
                                                )
                                                .toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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

class Label extends StatelessWidget {
  const Label({Key? key, required this.title}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.0.w,
          ),
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 245, 247),
                borderRadius: BorderRadius.circular(
                  5.0.sp,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.0.w,
                ),
                child: Text(
                  title!,
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
        ),
      ),
    );
  }
}

class PropertiesListBuilder extends StatelessWidget {
  const PropertiesListBuilder(
      {Key? key, required this.scrollController, required this.properties})
      : super(key: key);
  final ScrollController scrollController;
  final List<Property> properties;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 4.0.w,
        ),
        child: SizedBox(
          height: 30.0.h,
          child: Consumer<PropertiesProvider>(
            builder: (
              context,
              propertiesProviderData,
              child,
            ) =>
                properties.length == 0
                    ? TitleBuilder(title: "لا يوجد عقارات")
                    : ListView.builder(
                        clipBehavior: Clip.none,
                        controller: scrollController,
                        itemCount: properties.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (
                          BuildContext context,
                          int index,
                        ) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UnitDetailsScreen(),
                                ),
                              );
                            },
                            child: ChangeNotifierProvider<Property>.value(
                              value: properties[index],
                              child: UnitItem(),
                            ),
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
