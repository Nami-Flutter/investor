import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:speech/core/config/app_colors.dart';
import 'package:speech/core/config/app_strings.dart';
import 'package:speech/data/model/response/ChatModel.dart';
import 'package:speech/data/model/response/OrdersModel.dart';
import 'package:speech/data/repositries/SaveUserData.dart';
import 'package:speech/injection.dart';
import 'package:speech/presentation/screens/orders_chat/chat_screens/ChatViewModel.dart';
import 'package:speech/presentation/widgets/PopUpMenu.dart';
import '../../../../core/config/app_Images.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../widgets/ShowAnimationDialog.dart';
import '../../../widgets/default_text.dart';
import '../../../widgets/main_button.dart';
import '../../../widgets/text_button.dart';


ChatViewModel chatViewModel=getIt();
final SaveUserData saveUserData = getIt();
class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required this.ordersModel, required this.index})
      : super(key: key);

  OrdersModel ordersModel;
  int index;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  CustomPopupMenuController controller = CustomPopupMenuController();

  @override
  void initState() {
    chatViewModel.getMessageOrder(context, widget.ordersModel.data![widget.index].id);
    chatViewModel.onPlayerStateChanged();
    chatViewModel.onPositionChanged();
    chatViewModel.onDurationChanged();


    super.initState();
    KeyboardVisibilityController().onChange.listen((isVisible) {
      if (isVisible == false) {
        controller.hideMenu();
      }
    });

    // record = Record();
  }

  @override
  void dispose() {
    // Provider.of<ChatViewModel>(context,listen: false).record.dispose();
    // chatViewModel.audioPlayer.dispose();
    super.dispose();
  }
  String formatTime(int seconds) {
    return '${(Duration(
      seconds: seconds,
    ))}'
        .split('.')[0]
        .padLeft(0, '0');
  }

  bool check=false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<ChatViewModel>(
        builder: (context, value, child) => WillPopScope(
          onWillPop: () async {
            chatViewModel.stopAudio(index: chatViewModel.currentIndexPlaying).then((value) =>  chatViewModel.currentIndexPlaying=-1);
            chatViewModel.chatModel.data!.clear();
            chatViewModel.firstEnter=true;
             NavigationService.goBack();
            chatViewModel.duration = Duration.zero;
            chatViewModel.position = Duration.zero;

            return true;
          },
          child: Scaffold(
            body: Column(
              children: [
                _appBar(
                    image: AppImages.image,
                    name: widget.ordersModel.data![widget.index].investor!.name
                        .toString(),
                    projectName: widget
                        .ordersModel.data![widget.index].project!.name
                        .toString()),
                SizedBox(
                  height: .3.h,
                ),
                Expanded(
                  child:value.firstEnter==true?
                  value.isMessagesLoading == true
                      ? _messagesLoading()
                      :
                  value.chatModel.data!.isNotEmpty
                      ?  _messages(value.chatModel)
                      : _noMessages():
                  _messages(value.chatModel),
                ),
                widget.ordersModel.data![widget.index].status.toString() ==
                        "new"
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        color: Colors.white,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 6.h,
                              child: Material(
                                borderRadius: BorderRadius.circular(25),
                                child: Row(
                                  children: [
                                    _sendMessageIcon(),
                                    _formField(),
                                    chatViewModel.isRecording ==
                                            false
                                        ? _startRecordIcon()
                                        : _endRecordIcon(),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    PopUpMenu(
                                      popUpMenuButtons: [
                                        _cameraPopUpMenu(),
                                        _galleryPopUpMenu(),
                                      ],
                                      controller: controller,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            _dealButton()
                          ],
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _callType() {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //   builder: (context) => const VideoCall(),));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.camera_alt,
                      size: 20.w, color: AppColors.primaryColor),
                  DefaultText(
                    title: "مكالمه فيديو",
                    size: 10,
                    color: AppColors.normalText,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(context, MaterialPageRoute(
                //   builder: (context) => const AudioCall(),));
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone, size: 20.w, color: AppColors.primaryColor),
                  DefaultText(
                    title: "مكامله صوتيه",
                    size: 10,
                    color: AppColors.normalText,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cameraPopUpMenu() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            chatViewModel.sendImage(
                context: context,
                orderId: widget.ordersModel.data![widget.index].id.toString(),
                toUserId: widget
                    .ordersModel.data![widget.index].business_pioneer_id
                    .toString(),
                sendType: "camera");
            controller.hideMenu();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt, color: AppColors.primaryColor),
              SizedBox(
                width: 2.w,
              ),
              DefaultText(
                title: AppStrings.camera.tr(),
                size: 18,
                color: AppColors.boldText,
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  Widget _galleryPopUpMenu() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            chatViewModel.sendImage(
                context: context,
                orderId: widget.ordersModel.data![widget.index].id.toString(),
                toUserId: widget
                    .ordersModel.data![widget.index].business_pioneer_id
                    .toString(),
                sendType: "gallery");
            controller.hideMenu();
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera, color: AppColors.primaryColor),
              SizedBox(
                width: 2.w,
              ),
              DefaultText(
                title: AppStrings.gallery.tr(),
                size: 18,
                color: AppColors.boldText,
              )
            ],
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
      ],
    );
  }

  Widget _appBar(
      {required String image,
      required String name,
      required String projectName}) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(1.w),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                chatViewModel.stopAudio(index: chatViewModel.currentIndexPlaying).then((value) =>  chatViewModel.currentIndexPlaying=-1);
                chatViewModel.chatModel.data!.clear();
                chatViewModel.firstEnter=true;
                NavigationService.goBack();
                chatViewModel.duration = Duration.zero;
                chatViewModel.position = Duration.zero;
              },
              icon: const Icon(Icons.arrow_back)),
          CircleAvatar(
            backgroundColor: Colors.black,
            backgroundImage: AssetImage(image),
          ),
          SizedBox(
            width: 1.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Color(0xff2F3135)),
              ),
              Text(
                projectName,
                style: const TextStyle(fontSize: 12, color: Color(0xff686A71)),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: GestureDetector(
              onTap: () {

              },
              child: ImageIcon(
                AssetImage(AppImages.call),
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _messagesLoading() {
    return const Center(
        child: CircleAvatar(child: CircularProgressIndicator()));
  }

  Widget _noMessages() {
    return Center(
        child: Text(
      ("yourRequestHasNotBeenAnsweredYet").tr(),
      style: TextStyle(
        fontSize: 12.sp,
        color: AppColors.hintText,
        fontWeight: FontWeight.w300,
      ),
      textAlign: TextAlign.center,
      maxLines: 4,
    ));
  }

  Widget _messages(ChatModel chatModel,) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      reverse: true,
      itemCount: chatModel.data!.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 1.h,
      ),
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: chatModel.data![index].fromUser!.email ==
                saveUserData.getUserEmail()
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
              decoration: BoxDecoration(
                  color: chatModel.data![index].fromUser!.email ==
                          saveUserData.getUserEmail()
                      ? AppColors.primaryColor
                      : AppColors.hintText,
                  borderRadius:
                      Localizations.localeOf(context).languageCode == 'en' ||
                              chatModel.data![index].fromUser!.email ==
                                  saveUserData.getUserEmail()
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5))),
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
              child: chatModel.data![index].type == "text"
                  ? _text(
                      textMessage: chatModel.data![index].message.toString(),
                    )
                  : chatModel.data![index].type == "voice"
                      ? _slider(
                index: index,
                          audioPath: chatModel.data![index].attach,
                          max: chatViewModel.duration.inSeconds.toDouble(),
                          value: chatViewModel.position.inSeconds.toDouble(),)
                      : _image(
                          imageAttach: chatModel.data![index].attach.toString(),
                        )),
        ],
      ),
    );
  }

  Widget _text({required String textMessage,}) {
    return DefaultText(
      title: textMessage,
      size: 15,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w400,
      maxLines: 49,
    );
  }


  Widget _slider({required var audioPath,required double max,required double value,required int index}) {

    var data = chatViewModel.chatModel.data![index];
    return Column(
      children:[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Slider(
                min: 0,
                max: data.isPlaying?max:0,
                value:data.isPlaying?value:0,
                onChanged: (value) {
                final position=Duration(seconds: value.toInt());
                chatViewModel.audioPlayer.seek(position);
                chatViewModel.audioPlayer.resume();

                }),
            IconButton(
                onPressed: () {
                  chatViewModel.chatModel.data![index].isPlaying == false
                      ? chatViewModel.playAudio(audioPath,index)
                      : chatViewModel.stopAudio(index: index);
                },
                icon: data.isLoad==true?
                    const CircularProgressIndicator():
                 data.isPlaying == true
                    ? const Icon(Icons.stop)
                    : const Icon(Icons.play_arrow))
          ],
        ),
        Text(formatTime(data.isPlaying?chatViewModel.position.inSeconds:0)),
      ],
    );
  }


  Widget _image({required String imageAttach}) {
    return CachedNetworkImage(
      imageUrl: imageAttach,
      fit: BoxFit.fitWidth,
      width: 70.w,
      placeholder: (context, url) => SizedBox(
          height: 5.h,
          width: 5.w,
          child: CircleAvatar(
              radius: 2.w, child: const CircularProgressIndicator())),
    );
  }

  Widget _sendMessageIcon() {
    return IconButton(
        onPressed: () {
          if (chatViewModel.messageController
                  .text
                  .trim() !=
              "") {
            chatViewModel.sendMessage(
                context: context,
                orderId: widget.ordersModel.data![widget.index].id.toString(),
                toUserId: widget
                    .ordersModel.data![widget.index].business_pioneer_id
                    .toString());
          }
        },
        icon: ImageIcon(
          AssetImage(AppImages.send),
          color: AppColors.primaryColor,
        ));
  }

  Widget _formField() {
    return SizedBox(
      height: 13.h,
      width: 40.w,
      child: TextFormField(
        controller:chatViewModel.messageController,
        onChanged: (value) {
          // Provider.of<ChatViewModel>(context, listen: false)
          //     .messageController
          //     .text = value;
        },
      ),
    );
  }

  Widget _startRecordIcon() {
    return GestureDetector(
      onTap: () {
        chatViewModel.startRecording();
      },
      child: const Icon(Icons.mic, color: AppColors.primaryColor),
    );
  }

  Widget _endRecordIcon() {
    return GestureDetector(
      onTap: () {
        chatViewModel.sendVoice(
            context: context,
            orderId: widget.ordersModel.data![widget.index].id.toString(),
            toUserId: widget.ordersModel.data![widget.index].business_pioneer_id
                .toString());
      },
      child: const Icon(Icons.stop, color: AppColors.primaryColor),
    );
  }

  Widget _dealButton() {
    return SizedBox(
      height: 4.5.h,
      width: 17.w,
      child: MainButton(
        textSize: 11.sp,
        color: AppColors.primaryColor,
        title: AppStrings.deal.tr(),
        textColor: AppColors.whiteColor,
        onPressed: () {
          showAnimationDialog(
            context: context,
            title: "deals".tr(),
            message: "dealSuccess".tr(),
            needButtons: true,
            buttons: _rowButtons(),
            needRichText: true,
            titleMessage: "youShouldKnow".tr(),
            bodyMessage: "onCancelDeal".tr(),
          );
        },
      ),
    );
  }

  Widget _rowButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _concludingTheDeal(),
        _cancelDeal(),
      ],
    );
  }

  Widget _cancelDeal() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(7),
      child: ButtonText(
        textSize: 10.sp,
        textColor: AppColors.whiteColor,
        title: "cancelTheDeal".tr(),
        onPress: () {
          chatViewModel.changeOrderStatus(
              context: context,
              orderId: widget.ordersModel.data![widget.index].id,
              status: "cancelled");
        },
      ),
    );
  }

  Widget _concludingTheDeal() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(7),
      child: ButtonText(
        textSize: 10.sp,
        textColor: AppColors.whiteColor,
        title: "concludingTheDeal".tr(),
        onPress: () {
          chatViewModel.changeOrderStatus(
              context: context,
              orderId: widget.ordersModel.data![widget.index].id.toString(),
              status: "ended");
        },
      ),
    );
  }
}
