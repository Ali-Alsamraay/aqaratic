import 'package:aqaratak/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../helper/endpoints.dart';
import '../helper/networking.dart';
import '../models/get_lookups_info/get_lookups_info_model.dart';

class RegisterationScreen extends StatefulWidget {
  final String userId;

  const RegisterationScreen({required this.userId, Key? key}) : super(key: key);
  @override
  State<RegisterationScreen> createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  final _formKey = GlobalKey<FormState>();

  String userTypesDropdownValue = 'مطور عقاري';
  final List<String> userTypes = [];
  var _getData;
  String userTypeId = '';
  List<GetLookupsInfoModel> lookupsList = [];
  bool showLoader = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController regNumberController = TextEditingController();

  Future getUserTypes() async {
    Map<String, dynamic> paramaters = {'lookuptype': 'user_type'};
    NetworkHelper register = NetworkHelper(
        endpoint: lookupsEndpoint, params: paramaters, context: context);
    List dataMap = await register.getRequest();

    if (dataMap != null) {
      for (int i = 0; i < dataMap.length; i++) {
        lookupsList.add(GetLookupsInfoModel.fromJson(dataMap[i]));
        userTypes
            .add(GetLookupsInfoModel.fromJson(dataMap[i]).lookupname ?? '');
      }
      userTypeId = lookupsList[0].id!;

      print(userTypes);
    }
    return userTypes;
  }

  Future register() async {
    Map<String, dynamic> paramaters = {
      "name": nameController.text,
      "reg_number": regNumberController.text,
      "email": emailController.text,
      "usertype": userTypeId
    };
    NetworkHelper register = NetworkHelper(
        endpoint: registerEndpoint + widget.userId,
        params: paramaters,
        context: context);
    var dataMap = await register.patchRequest();
    if (dataMap != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainScreen()));
    }
    setState(() {
      showLoader = false;
    });
  }

  @override
  void initState() {
    _getData = getUserTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: _getData,
      builder: (context, snapshot) {
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: LoadingOverlay(
                  isLoading: showLoader,
                  child: Material(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("تسجيل جديد",
                              style: TextStyle(
                                color: Color(0xfffefeff),
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 0.9,
                              )),
                          const Text("ادخل بياناتك الشخصية",
                              style: TextStyle(
                                color: Color(0xffb78457),
                                fontSize: 21,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.account_circle_outlined,
                                  color: Color(0xffb78457),
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      controller: nameController,
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'الرجاء إدخال الإسم';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: 'الإسم',
                                          hintStyle: TextStyle(
                                              color: Color(0xffb3bbcb),
                                              fontSize: 20)),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.alternate_email_rounded,
                                  color: Color(0xffb78457),
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'الرجاء إدخال إدخال البريد الإلكترومي';
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: 'البريد الإلكتروني',
                                          hintStyle: TextStyle(
                                              color: Color(0xffb3bbcb),
                                              fontSize: 20)),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.account_circle_outlined,
                                  color: Color(0xffb78457),
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: DropdownButton<String>(
                                      value: userTypesDropdownValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          userTypesDropdownValue = newValue!;
                                        });
                                        userTypeId = lookupsList[lookupsList
                                                    .indexWhere((element) =>
                                                        element.lookupname ==
                                                        newValue)]
                                                .id ??
                                            '';
                                      },
                                      items: userTypes.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                                      isExpanded: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 70,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.app_registration_rounded,
                                  color: Color(0xffb78457),
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                    width: 200,
                                    child: TextFormField(
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'الرجاء إدخال رقم الترخيص';
                                        }
                                        return null;
                                      },
                                      controller: regNumberController,
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      decoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText: 'رقم الترخيص',
                                          hintStyle: TextStyle(
                                              color: Color(0xffb3bbcb),
                                              fontSize: 20)),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  register();
                                }
                              },
                              child: const Text(
                                'التالي',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xffb78457)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            // empty data case
            return Container();
          }
        } else {
          return AlertDialog(
            content: Text('State: ${snapshot.connectionState}'),
          );
        }
      });
}
