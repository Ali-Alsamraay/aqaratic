import 'package:aqaratak/models/Blog.dart';
import 'package:aqaratak/models/FormValidator.dart';
import 'package:aqaratak/providers/Blogs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/constants.dart';
import 'package:sizer/sizer.dart';

import '../widgets/Custom_TextField.dart';
import '../widgets/dropDownMenu.dart';

class BlogDetailsScreen extends StatefulWidget {
  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  final GlobalKey<FormState>? _formKey = new GlobalKey();

  @override
  void dispose() {
    if (_formKey != null && _formKey!.currentState != null) {
      _formKey!.currentState!.dispose();
    }
    super.dispose();
  }

  Map<String, dynamic> comment = {
    'name': '',
    'email': '',
    'comment': '',
  };

  @override
  Widget build(BuildContext context) {
    final int? blogId = ModalRoute.of(context)!.settings.arguments as int;

    final Blog? selectedBlog =
        Provider.of<BlogsProvider>(context, listen: false).getBlogById(blogId);
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.0.h),
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: 0,
                  offset: Offset(2.0, -2.0),
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
                        'تفاصيل المدونة',
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
        body: GestureDetector(
          onTap: () {
            if (FocusManager.instance.primaryFocus!.hasFocus)
              FocusManager.instance.primaryFocus!.unfocus();
          },
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 25.0.h,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          child: ClipRRect(
                            child: selectedBlog!.image == null
                                ? Center(
                                    child: Text("لا توجد صورة"),
                                  )
                                : selectedBlog.image!.isNotEmpty
                                    ? FadeInImage.assetNetwork(
                                        imageErrorBuilder:
                                            (context, error, stackTrace) =>
                                                Center(
                                          child: Text("لا توجد صورة"),
                                        ),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        placeholder: imagePath + 'splash.png',
                                        image:
                                            baseUrl + "/" + selectedBlog.image!,
                                      )
                                    : Image.asset(
                                        imagePath + 'background.png',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                          width: 20.0.w,
                          height: 4.0.h,
                          decoration: BoxDecoration(
                            color: accentColorBlue.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(
                              5.0.sp,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                selectedBlog.view == null
                                    ? ''
                                    : selectedBlog.view!.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                ),
                              ),
                              Icon(
                                Icons.chat_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${selectedBlog.title!.toString()} ',
                          style: TextStyle(
                            color: accentColorBlue,
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Text(
                      selectedBlog.short_description ?? '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff0c2757),
                        fontSize: 11.0.sp,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.0.h,
                  ),
                  Divider(thickness: 1.0.sp),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Text(
                      selectedBlog.description ?? '',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color(0xff0c2757),
                        fontSize: 10.0.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "التعليقات",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff0c2757),
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(
                          width: 2.0.w,
                        ),
                        Text(
                          "(${selectedBlog.comments!.length.toString()})",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xff0c2757),
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  ...selectedBlog.comments!.map((comment) {
                    return CommentItem(
                      comment: comment.comment!,
                      name: comment.name!,
                      date: comment.created_at!,
                    );
                  }).toList(),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "أضف تعليق",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Color(0xff0c2757),
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  enabledBorderColor: accentColorBlue,
                                  onSaveFunc: (value) {
                                    comment['name'] = value!.trim();
                                  },
                                  onValidateFunc: (value) {
                                    return FormValidator()
                                        .validateTextField(value!.trim());
                                  },
                                  label: "الإسم",
                                  linesNumber: 1,
                                  focusedBorderColor: accentColorBlue,
                                ),
                              ),
                              SizedBox(
                                width: 2.0.w,
                              ),
                              Expanded(
                                child: CustomTextField(
                                  enabledBorderColor: accentColorBlue,
                                  onSaveFunc: (value) {
                                    comment['email'] = value!.trim();
                                  },
                                  onValidateFunc: (value) {
                                    return FormValidator()
                                        .validateEmail(value!.trim());
                                  },
                                  label: "البريد الإلكتروني",
                                  linesNumber: 1,
                                  focusedBorderColor: accentColorBlue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          CustomTextField(
                            scrollPadding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).viewInsets.bottom +
                                      10.0.h,
                            ),
                            enabledBorderColor: accentColorBlue,
                            onSaveFunc: (value) {
                              comment['comment'] = value!.trim();
                            },
                            onValidateFunc: (value) {
                              return FormValidator()
                                  .validateTextField(value!.trim());
                            },
                            label: "التعليقات",
                            linesNumber: 5,
                            focusedBorderColor: accentColorBlue,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey!.currentState!.validate()) {
                            _formKey!.currentState!.save();

                            await Provider.of<BlogsProvider>(
                              context,
                              listen: false,
                            ).createComment(
                              comment,
                              selectedBlog.id!,
                            );
                            await ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("تمت إضافة التعليق",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0.sp,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                    )),
                                duration: Duration(milliseconds: 400),
                                backgroundColor: accentColorBlue,
                              ),
                            );
                            await Provider.of<BlogsProvider>(
                              context,
                              listen: false,
                            ).get_all_blogs();
                            setState(() {});
                            _formKey!.currentState!.reset();
                            comment = {
                              'name': '',
                              'email': '',
                              'comment': '',
                            };
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(accentColorBlue),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              horizontal: 4.0.w,
                              vertical: 1.0.h,
                            ),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                10.0.sp,
                              ),
                              side: BorderSide(
                                color: accentColorBlue,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          "إرسال",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.0.sp,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  const CommentItem(
      {Key? key, required this.comment, required this.name, required this.date})
      : super(key: key);
  final String comment;
  final String name;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.0.h),
      margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 2.0.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0.sp,
        ),
        color: greyColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                name.toString(),
                style: TextStyle(
                  color: accentColorBlue,
                  fontSize: 11.0.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                date.toString(),
                style: TextStyle(
                  color: accentColorBlue,
                  fontSize: 10.0.sp,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                comment.toString(),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: accentColorBlue,
                  fontSize: 10.0.sp,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ]),
          ),
          SizedBox(
            width: 2.0.w,
          ),
          Expanded(
            child: CircleAvatar(
              radius: 20.0.sp,
              backgroundImage: AssetImage(imagePath + 'appicon.png'),
              backgroundColor: accentColorBlue,
            ),
          ),
        ],
      ),
    );
  }
}
