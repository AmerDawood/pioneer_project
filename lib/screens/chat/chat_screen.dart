
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pioneer_project/screens/chat/select_chat_screen.dart';

import '../../helpers/spacing.dart';
import '../../theming/colors.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  late TextEditingController _messageEditingController;







  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _messageEditingController = TextEditingController();

  }


  @override
  void dispose() {
    // TODO: implement dispose
    _messageEditingController.dispose();

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
          elevation: 0,
          title: Text(
            'ANERA',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                return SelectChatScreen();
              }));
            },
          ),
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            // ),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 600.h,
                  child:ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext ctx, value) {
                        return Column(
                          children: [
                            // Message
                            Padding(
                              padding: EdgeInsets.only(
                                right: 20.w,
                                bottom: 10,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: ColorsManager.primary,
                                    ),
                                    horizontalSpace(5),
                                    Container(
                                      height: 44.h,
                                      // width: 285.w,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            229, 229, 229, 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(7.0.sp),
                                        child: Text(
                                          'السلام عليكم ورحمه الله ',
                                          style: GoogleFonts.tajawal(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Reply
                            Padding(
                              padding: EdgeInsets.only(
                                top: 0.h,
                                left: 20.w,
                                bottom: 10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      height: 44.h,
                                      // width: 209.w,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(
                                            229, 229, 229, 1),
                                        borderRadius:
                                        BorderRadius.circular(15.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(7.0.sp),
                                        child: Text(
                                          'وعليكم السلام ',
                                          style: GoogleFonts.tajawal(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(5),
                                  CircleAvatar(
                                    backgroundColor: ColorsManager.secondary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
            Positioned(
              bottom: 0.h,
              left: 10.w,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60.h,
                      width: 300.w,
                      child: TextField(
                        controller: _messageEditingController,
                        cursorColor: Colors.grey,
                        cursorWidth: 2.w,
                        style: TextStyle(
                          // color: Color.fromRGBO(186, 186, 186,1),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          // suffixIcon: Icon(Icons.send,color: Colors.black,),
                          hintText: 'اكتب رسالتك هنا',
                          hintStyle: GoogleFonts.tajawal(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0.r),
                            borderSide: BorderSide(color: Colors.grey, width: 2.w),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0.r),
                            borderSide: BorderSide(color: Colors.grey, width: 2.w),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0.r),
                            borderSide: BorderSide(color: Colors.grey, width: 2.w),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace(10),

                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: Center(
                          child: InkWell(
                              onTap: () {
                                // _addMessage(
                                //     context
                                // );
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.black,
                              ))),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
