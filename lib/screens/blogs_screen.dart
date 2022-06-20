import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/models/Blog.dart';
import 'package:aqaratak/providers/Blogs_provider.dart';
import 'package:aqaratak/screens/unit_details_screen.dart';
import 'package:aqaratak/widgets/Blog_Item.dart';
import 'package:aqaratak/widgets/Title_Builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../widgets/dropDownMenu.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);
  static const String screenName = "blogs-screen";

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  final ScrollController? filtrationScrollController = ScrollController();
  bool? loading = true;
  bool isCalled = false;
  @override
  void initState() {
    super.initState();
    final BlogsProvider blogsProvider =
        Provider.of<BlogsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        await blogsProvider.get_all_blogs();
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

    filtrationScrollController!.addListener(() {
      if (isCalled) return;
      isCalled = true;
      if (filtrationScrollController!.position.pixels >=
          filtrationScrollController!.position.maxScrollExtent) {
        // propertiesProvider.gettingMoreData(true);
        isCalled = false;
        // propertiesProvider.gettingMoreData(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.0.h),
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 0,
                  offset: Offset(2.0, -2.0), // shadow direction: bottom right
                )
              ],
              color: accentColorBlue,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                  Row(
                    children: [
                      Text(
                        'كل المدونات',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 3.0.w,
                      ),
                      DropDownMenu(
                        color: Colors.white,
                        backgroundColor: accentColorBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          height: 100.0.h,
          width: 100.0.w,
          child: loading!
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Consumer<BlogsProvider>(
                  builder: (
                    context,
                    BlogsProvider blogsProvider,
                    child,
                  ) =>
                      blogsProvider.blogs.length == 0
                          ? Center(
                              child: TitleBuilder(
                                title: 'لا توجد مدونات',
                              ),
                            )
                          : ListView.builder(
                              itemCount: blogsProvider.blogs.length,
                              scrollDirection: Axis.vertical,
                              controller: filtrationScrollController,
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
                                  child: ChangeNotifierProvider<Blog>.value(
                                    value: blogsProvider.blogs[index],
                                    child: Container(
                                      height: 35.0.h,
                                      margin:
                                          EdgeInsets.symmetric(vertical: 1.0.h),
                                      child: BlogItem(),
                                    ),
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
