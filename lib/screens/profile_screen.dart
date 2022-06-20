import 'package:aqaratak/helper/constants.dart';
import 'package:aqaratak/providers/Auth_Provider.dart';
import 'package:aqaratak/providers/main_provider.dart';
import 'package:aqaratak/screens/blogs_screen.dart';
import 'package:aqaratak/screens/login_screen.dart';
import 'package:aqaratak/screens/main_screen.dart';
import 'package:aqaratak/screens/my_orders_screen.dart';
import 'package:aqaratak/screens/update_user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'creating_property_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool? isCurrentUserLoggedIn = false;
  bool? loading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        setState(() {
          loading = true;
        });
        isCurrentUserLoggedIn = await Provider.of<AuthProvider>(
          context,
          listen: false,
        ).isCurrentUserLoggedIn();
        await Provider.of<MainProvider>(context, listen: false)
            .get_contracts_file();
        setState(() {
          loading = false;
        });
      } catch (e) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        color: Color(0xffE9EAEE),
        height: 100.0.h,
        width: 100.0.w,
        child: loading!
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : FutureBuilder(
                future: Provider.of<AuthProvider>(context, listen: false)
                    .getCachedUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    final AuthProvider? auth =
                        Provider.of<AuthProvider>(context, listen: false);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5.0.h,
                          ),
                          SizedBox(
                            height: 20.0.h,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        10.0.sp,
                                      ),
                                      child: Container(
                                        width: 25.0.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: accentColorBrown,
                                        ),
                                        child: !isCurrentUserLoggedIn!
                                            ? Center(
                                                child: SvgPicture.asset(
                                                  'assets/images/person_icon.svg',
                                                  color: backgroundColor,
                                                  height: 10.0.w,
                                                  width: 10.0.w,
                                                ),
                                              )
                                            : authProvider.currentUser!.image!
                                                    .isNotEmpty
                                                ? Container(
                                                    width: 15.0.w,
                                                    height: 15.0.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          authProvider
                                                              .currentUser!
                                                              .image!,
                                                        ),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  )
                                                : SvgPicture.asset(
                                                    'assets/images/person_icon.svg',
                                                    color: backgroundColor,
                                                    height: 10.0.w,
                                                    width: 10.0.w,
                                                  ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                ),
                                Expanded(
                                  child: Text(
                                    isCurrentUserLoggedIn!
                                        ? authProvider.currentUser!.name!
                                        : "ضيف",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.cairo(
                                      textStyle: TextStyle(
                                        color: accentColorBlue,
                                        fontWeight: FontWeight.w800,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 15.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0.h,
                          ),
                          _ProfileButton(
                            onTab: () async {
                              final bool? isUserLoggedIn =
                                  await auth!.isCurrentUserLoggedIn();
                              if (!isUserLoggedIn!) {
                                Navigator.of(context).pushNamed(
                                  LoginScreen.screenName,
                                );
                                return;
                              }
                              Navigator.of(context).pushNamed(
                                UpdateUserProfileScreen.screenName,
                              );
                            },
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/images/person_icon.svg',
                            title: isCurrentUserLoggedIn!
                                ? 'تعديل الملف الشخصي'
                                : "تسجيل دخول",
                          ),
                          _ProfileButton(
                            onTab: () async {
                              final bool? isUserLoggedIn =
                                  await auth!.isCurrentUserLoggedIn();
                              if (!isUserLoggedIn!) {
                                Navigator.of(context).pushNamed(
                                  LoginScreen.screenName,
                                );
                                return;
                              }
                              Navigator.of(context).pushNamed(
                                CreatingPropertyScreen.screenName,
                              );
                            },
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/icons/plus.png',
                            title: "أضف عقارك",
                          ),
                          _ProfileButton(
                            onTab: () {
                              Navigator.of(context).pushNamed(
                                MyOrdersScreen.screenName,
                              );
                            },
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/images/requests_icon.svg',
                            title: "طلباتي",
                          ),
                          _ProfileButton(
                            icon: Icons.arrow_forward_ios,
                            iconAtStart: Icons.book_outlined,
                            title: "المدونة",
                            onTab: () {
                              Navigator.of(context).pushNamed(
                                BlogsScreen.screenName,
                              );
                            },
                          ),
                          _ProfileButton(
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/images/ads_icon.svg',
                            title: "إعلاناتي",
                            onTab: () {},
                          ),
                          _ProfileButton(
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/images/fav_icon.svg',
                            title: "المفضلة",
                            onTab: () {},
                          ),
                          _ProfileButton(
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/images/contact_icon.svg',
                            title: "اتصل بنا",
                            onTab: () {},
                          ),
                          _ProfileButton(
                            icon: Icons.arrow_forward_ios,
                            iconPath: 'assets/images/about_icon.svg',
                            title: "من نحن",
                            onTab: () {},
                          ),
                          _ProfileButton(
                            icon: Icons.arrow_forward_ios,
                            iconPath: null,
                            iconAtStart: !isCurrentUserLoggedIn!
                                ? Icons.login
                                : Icons.logout,
                            title: !isCurrentUserLoggedIn!
                                ? "تسجيل الدخول"
                                : "تسجيل الخروج",
                            onTab: () async {
                              if (!isCurrentUserLoggedIn!) {
                                Navigator.of(context)
                                    .pushNamed(LoginScreen.screenName);
                                return;
                              }
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .logout();
                              Navigator.of(context).pushNamed(
                                MainScreen.screenName,
                              );
                            },
                          ),
                          SizedBox(
                            height: 15.0.h,
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
                },
              ),
      ),
    );
  }
}

class _ProfileButton extends StatelessWidget {
  const _ProfileButton({
    Key? key,
    required this.title,
    this.iconPath,
    required this.icon,
    this.iconAtStart,
    this.onTab,
  }) : super(key: key);
  final String? title;
  final String? iconPath;
  final IconData? icon;
  final void Function()? onTab;
  final IconData? iconAtStart;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 0.7.h),
      child: InkWell(
        onTap: onTab,
        child: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    iconPath == null
                        ? iconAtStart != null
                            ? Icon(
                                iconAtStart,
                                color: accentColorBlue,
                                size: 17.0.sp,
                              )
                            : Container()
                        : iconPath!.endsWith("svg")
                            ? SvgPicture.asset(
                                iconPath!,
                                height: 5.0.w,
                                width: 5.0.w,
                                color: accentColorBlue,
                              )
                            : Image.asset(
                                iconPath!,
                                height: 5.0.w,
                                width: 5.0.w,
                                color: accentColorBlue,
                              ),
                    SizedBox(
                      width: 7.0.w,
                    ),
                    Text(
                      title!,
                      style: TextStyle(
                        color: accentColorBlue,
                        fontSize: 11.0.sp,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      icon,
                      color: accentColorBlue,
                      size: 15.0.sp,
                    ),
                    SizedBox(
                      width: 10.0.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
