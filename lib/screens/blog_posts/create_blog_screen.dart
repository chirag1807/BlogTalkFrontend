import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:blogtalk/providers/CreateBlogProvider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/widgets.dart';
import '../bottom_navbar/bottom_navbar_screen.dart';
import 'package:get/get.dart';

class CreateBlogScreen extends StatefulWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {

  TextEditingController addTitleCtrl = TextEditingController();
  TextEditingController addContentCtrl = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    addTitleCtrl.dispose();
    addContentCtrl.dispose();
  }

  HashMap<int, String> leadTypeNameId = HashMap<int, String>();
  int blogTopicValue = -1;
  File? coverImg;

  @override
  Widget build(BuildContext context) {
    double w = getWidth(context);
    double h = getHeight(context);
    
    return ChangeNotifierProvider(
      create: (context) =>  CreateBlogProvider(),
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: themeColorBlue,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: text("Create Blog", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: appBodyGradient(),
                border: const Border(
                  bottom: BorderSide(
                    color: themeColorWhite,
                    width: 2.0
                  )
                )
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              width: w,
              height: h,
              padding: const EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                gradient: appBodyGradient()
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding: const EdgeInsets.only(left: 10.0,),
                    //   child: text("Create Blog", 20, FontWeight.w700, themeColorWhite, TextDecoration.none, TextAlign.center),
                    // ),
                    // const SizedBox(height: 5,),
                    // const Divider(color: themeColorWhite, thickness: 3.0,),
                    Consumer<CreateBlogProvider>(
                      builder: (context, provider, index){
                        coverImg = provider.imageFile;
                      return InkWell(
                        onTap: () async {
                          try{
                            XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if(pickedImage != null){
                              File pickedFileImage = File(pickedImage.path);
                              provider.pickImage(pickedFileImage);
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(errorMsg, themeColorSnackBarRed));
                            }
                          } catch(e) {
                            ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(e.toString(), themeColorSnackBarRed));
                          }
                        },
                        child: Container(
                          width: w,
                          height: 240,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: themeColorWhite)
                            )
                          ),
                          child: coverImg != null ?
                             Image.file(
                               coverImg!,
                               fit: BoxFit.cover,
                             ) :
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.photo, color: themeColorWhite, size: 100,),
                              const SizedBox(height: 5.0,),
                              text("Add Cover photo", 12, FontWeight.w400, themeColorWhite, TextDecoration.none, TextAlign.center)
                            ],
                          ),
                        ),
                      );
                      }
                    ),
                    const SizedBox(height: 20.0,),
                    Consumer<CreateBlogProvider>(
                      builder: (context, provider, child){
                        if(provider.circularBarShow == 1){
                          Future.microtask(() => provider.getAllTopicNameIds(-1));
                        }
                        blogTopicValue = provider.blogTopic;
                      return Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            value: blogTopicValue != -1 ? blogTopicValue : null,
                            items: provider.topicNameIds.map((key, value) {
                              return MapEntry(key, DropdownMenuItem(value: key, child: Text(value,
                                style: const TextStyle(color: themeColorWhite),),));
                            }).values.toList(),
                            onChanged: (value) {
                              provider.changeBlogTopic(value as int);
                            },
                            dropdownColor: themeColorBlue,
                            isExpanded: true,
                            icon: provider.circularBarShow == 1 ?
                            const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: themeColorWhite, strokeWidth: 2.5,))
                                : const Icon(Icons.expand_more, color: themeColorWhite,),
                            decoration: InputDecoration(
                              labelText: "Select Topic",
                              labelStyle: const TextStyle(color: themeColorHint1),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: themeColorWhite),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: themeColorWhite),
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                            ),
                            focusColor: themeColorWhite,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ),
                      );
                      }
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: TextFormField(
                          controller: addTitleCtrl,
                          keyboardType: TextInputType.text,
                          cursorColor: themeColorWhite,
                          textCapitalization: TextCapitalization.words,
                          style: const TextStyle(
                              color: themeColorWhite
                          ),
                          decoration: InputDecoration(
                            hintText: "Add Title",
                            hintStyle: const TextStyle(
                                color: themeColorHint1
                            ),
                            enabledBorder:
                            OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: themeColorWhite,
                                    width: 2
                                )
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: themeColorWhite,
                                    width: 2
                                )
                            ),
                          ),
                        ),
                    ),
                    const SizedBox(height: 20.0,),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        controller: addContentCtrl,
                        keyboardType: TextInputType.multiline,
                        cursorColor: themeColorWhite,
                        textInputAction: TextInputAction.newline,
                        minLines: 6,
                        maxLines: null,
                        textCapitalization: TextCapitalization.words,
                        style: const TextStyle(
                            color: themeColorWhite
                        ),
                        decoration: InputDecoration(
                          hintText: "Add Content",
                          hintStyle: const TextStyle(
                              color: themeColorHint1
                          ),
                          enabledBorder:
                          OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: themeColorWhite,
                                  width: 2
                              )
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color: themeColorWhite,
                                  width: 2
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: h * 0.08,
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 10),
                ],
                color: themeColorBlue
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Consumer<CreateBlogProvider>(
                    builder: (context, provider, child){
                      if(provider.successSavePost == 1){
                        print("fromSuccessSavePost1");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(displaySnackBar("Post Saved to Draft Successfully", themeColorSnackBarGreen));
                        });
                        Timer(const Duration(seconds: 1), () {
                          Get.offAll(() => const BottomNavBarScreen());
                        });
                      }
                      if(provider.successSavePost == 0){
                        print("fromSuccessSavePost0");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(errorMsg, themeColorSnackBarRed));
                        });
                      }
                    return InkWell(
                      onTap: (){
                        if(coverImg != null){
                          provider.savePostToDraft(addTitleCtrl.text, addContentCtrl.text, blogTopicValue, coverImg!.path);
                        }
                        else{
                          provider.savePostToDraft(addTitleCtrl.text, addContentCtrl.text, blogTopicValue, "");
                        }
                      },
                      child: Container(
                        width: w * 0.4,
                        alignment: Alignment.center,
                        child: provider.circularBarShowSaveBlogPost == 1 ?
                            const CircularProgressIndicator(color: themeColorWhite,) :
                        const Text("Save to Draft", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: themeColorWhite
                        ),),
                      ),
                    );
                    }
                  ),
                  const VerticalDivider(thickness: 1, color: themeColorWhite,),
                  Consumer<CreateBlogProvider>(
                    builder: (context, provider, child){
                      if(provider.successUploadPost == 1){
                        print("fromSuccessUploadPost1");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(displaySnackBar("Post Uploaded Successfully", themeColorSnackBarGreen));
                        });
                        Timer(const Duration(seconds: 1), () {
                          Get.offAll(() => const BottomNavBarScreen());
                        });
                      }
                      if(provider.successUploadPost == 0){
                        print("fromSuccessUploadPost0");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(displaySnackBar(errorMsg, themeColorSnackBarRed));
                        });
                      }
                    return InkWell(
                      onTap: (){
                        provider.uploadPost("", addTitleCtrl.text, addContentCtrl.text, blogTopicValue, coverImg, 0);
                      },
                      child: Container(
                        width: w * 0.4,
                        alignment: Alignment.center,
                        child: provider.circularBarShowBlogPost == 1 ?
                        const CircularProgressIndicator(color: themeColorWhite,) :
                        const Text("Publish", style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                            color: themeColorWhite
                        ),),
                      ),
                    );
                    }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
