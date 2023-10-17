import 'dart:core';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:speech/data/model/response/ChatModel.dart';
import 'package:speech/data/repositries/ChatRepo.dart';
import 'package:speech/presentation/screens/orders_chat/OrdersViewModel.dart';
import '../../../../core/routing/navigation_services.dart';
import '../../../../core/utils/api_checker.dart';
import '../../../../data/model/response/base/api_response.dart';

class ChatViewModel with ChangeNotifier {

  final ChatRepo chatRepo;


  ChatViewModel({required this.chatRepo,});


  ///variables
  bool _isSendImageLoading = false;
  bool _isSendMessageLoading = false;
  bool _isMessagesLoading = false;
  bool _isSendVoiceLoading = false;
  bool _isChangeOrderStatusLoading = false;
  bool _isPhotoLoading=false;


  bool firstEnter=true;

  ImagePicker picker = ImagePicker();
  TextEditingController messageController = TextEditingController();

  ///getters
  bool get isSendImageLoading => _isSendImageLoading;
  bool get isSendMessageLoading => _isSendMessageLoading;
  bool get isPhotoLoading => _isPhotoLoading;
  bool get isMessagesLoading => _isMessagesLoading;
  bool get isVoiceLoading => _isSendVoiceLoading;
  bool get isChangeOrderStatusLoading => _isChangeOrderStatusLoading;


  ///calling APIs Functions

ChatModel chatModel=ChatModel();

  set currentOrders (ChatModel chatModel) {
    notifyListeners();
  }


  Future<ApiResponse> getMessageOrder( context,orderId) async {
    _isMessagesLoading = true;
    ApiResponse responseModel = await chatRepo.getMessageOrder(orderId);

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isMessagesLoading = false;
      firstEnter=false;
      chatModel = ChatModel.fromJson(responseModel.response?.data);
      if(chatModel.data!.isEmpty){
        firstEnter=true;
      }
    }
    else
    {
      _isMessagesLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isMessagesLoading = false;
    notifyListeners();
    return responseModel;
  }


  Future<ApiResponse> changeOrderStatus({required context,required  orderId,required status}) async {
    _isChangeOrderStatusLoading = true;
    var data={
      "status":status
    };
    ApiResponse responseModel = await chatRepo.changeOrderStatus(data,orderId);

    if (responseModel.response != null &&
        responseModel.response?.statusCode == 200) {
      _isChangeOrderStatusLoading = false;
      Provider.of<OrdersViewModel>(context,listen: false).getCurrentOrders(context);
      Provider.of<OrdersViewModel>(context,listen: false).getCompletedOrders(context);
      NavigationService.goBack(context);
      NavigationService.goBack(context);
    }
    else
    {
      _isChangeOrderStatusLoading = false;
      ApiChecker.checkApi(context, responseModel);
    }
    _isChangeOrderStatusLoading = false;
    notifyListeners();
    return responseModel;
  }



  sendMessage({required context,required String toUserId,required String orderId }) async {
    _isSendMessageLoading = true;
      FormData data = FormData.fromMap(
          {"to_user_id":toUserId,
            "message":messageController.text,
            "type":"text",
            'attach':"",
            "order_id":orderId,});
    messageController.text="";
      ApiResponse responseModel = await chatRepo.sendMessage(data);
      if (responseModel.response != null &&
          responseModel.response?.statusCode == 200) {
        _isSendMessageLoading = false;
        getMessageOrder(context,orderId);
      }
      else
      {
        _isSendMessageLoading = false;
        ApiChecker.checkApi(context, responseModel);
      }
    _isSendMessageLoading = false;
      notifyListeners();
      return responseModel;

  }


  sendImage({required  context,required String sendType,required String toUserId,required String orderId })async{
    _isSendImageLoading = true;
    var result;
    if(sendType=="camera"){
      result = await picker.pickImage(source: ImageSource.camera);
    }else{
      result = await picker.pickImage(source: ImageSource.gallery);
    }
    File? file;
    if (result != null) {
      file = File(result.path);
      FormData data = FormData.fromMap(
          {"to_user_id":toUserId,
            "message":"",
            "type":"image",
            'attach': await MultipartFile.fromFile(file.path)
            , "order_id":orderId,});
      ApiResponse responseModel = await chatRepo.sendMessage(data);
      print(file.path);
      if (responseModel.response != null &&
          responseModel.response?.statusCode == 200) {
        getMessageOrder(context,orderId);
        _isSendImageLoading = false;
      }
      else
      {
        _isSendImageLoading = false;
        ApiChecker.checkApi(context, responseModel);
      }
      _isSendImageLoading = false;
      notifyListeners();
      return responseModel;
    }
  }

  sendVoice({required  context,required String toUserId,required String orderId})async{
    _isSendVoiceLoading = true;
    var result;
    try {
      var path = await record.stop();
      print("stop");
      result = path!;
      isRecording = false;
      notifyListeners();
    } catch (e) {
      print("error while stop recording $e");
    }
    File? file;
    if (result != null) {
      file = File(result);
      FormData data = FormData.fromMap(
          {"to_user_id":toUserId,
            "message":"",
            "type":"voice",
            'attach': await MultipartFile.fromFile(file.path)
            , "order_id":orderId,});
      ApiResponse responseModel = await chatRepo.sendMessage(data);
      print(file.path);
      if (responseModel.response != null &&
          responseModel.response?.statusCode == 200) {
        getMessageOrder(context,orderId);
        _isSendVoiceLoading = false;
      }
      else
      {
        _isSendVoiceLoading = false;
        ApiChecker.checkApi(context, responseModel);
      }
      _isSendVoiceLoading = false;
      notifyListeners();
      return responseModel;
    }
  }


  // var record=AudioRecorder();
  Record record =Record();
  bool isRecording = false;
  AudioPlayer audioPlayer = AudioPlayer();
  int currentIndexPlaying = -1;
  bool isPlaying=false;
  bool isAudioFinish=true;

  Future<void> startRecording() async {
    try {
      if (await record.hasPermission()) {
        await record.start();
        print("start");
          isRecording = true;
          notifyListeners();
      }
    } catch (e) {
      print("error while start recording $e");
    }
  }



  Future<void> playAudio(audioPath,index) async {
    if(currentIndexPlaying==-1||currentIndexPlaying==index){
      currentIndexPlaying=index;
      isAudioFinish=false;
      chatModel.data![index].isLoad=true;
      notifyListeners();
      try {
        Source source = UrlSource(audioPath);


        await audioPlayer.play(source).then((value) {
          chatModel.data![index].isLoad=false;
          chatModel.data![index].isPlaying=true;
          notifyListeners();
        });
        notifyListeners();
        audioPlayer.onPlayerComplete.listen((event) {
          duration = Duration.zero;
          position = Duration.zero;
          chatModel.data![index].isPlaying=false;
          isAudioFinish=true;
          notifyListeners();
        });

      } catch (e) {
        print("error while play recording $e");
        chatModel.data![index].isPlaying=false;
        notifyListeners();
      }
    }
    else{
      duration = Duration.zero;
      position = Duration.zero;
      chatModel.data![index].isLoad=true;
      stopAudio(index: currentIndexPlaying).then((value) async {
        chatModel.data![index].isLoad=false;
        currentIndexPlaying=index;
        chatModel.data![currentIndexPlaying].isPlaying=false;
        isAudioFinish=false;
        notifyListeners();
        try {
          Source source = UrlSource(audioPath);
          chatModel.data![index].isPlaying=true;
          await audioPlayer.play(source);
          notifyListeners();
          audioPlayer.onPlayerComplete.listen((event) {
            isAudioFinish=true;
            currentIndexPlaying=-1;
            chatModel.data![index].isPlaying=false;
            notifyListeners();
          });

        } catch (e) {
          print("error while play recording $e");
          chatModel.data![index].isPlaying=false;
          notifyListeners();
        }
      });

    }
    chatModel.data![index].isLoad=false;
    notifyListeners();
  }


  Future<void> stopAudio({required int index}) async {
    if(isAudioFinish==true){
      try {
        await audioPlayer.stop().whenComplete((){
          duration = Duration.zero;
          position = Duration.zero;
          notifyListeners();
        });
        chatModel.data![index].isPlaying=false;
        notifyListeners();
      } catch (e) {
        print("error while play recording $e");
      }
    }else{
      try {
        await audioPlayer.pause().whenComplete((){
          notifyListeners();
        });
        chatModel.data![index].isPlaying=false;
        notifyListeners();
      } catch (e) {
        print("error while play recording $e");
      }
    }

  }



  Future<void> resumeAudio(index) async {
    try {
      await audioPlayer.resume();
      chatModel.data![index].isPlaying=false;
      notifyListeners();
    } catch (e) {
      print("error while play recording $e");
    }
  }



  Duration duration = Duration.zero;
  Duration position = Duration.zero;


  onPlayerStateChanged() {
   audioPlayer.onPlayerStateChanged.listen((state) {
     isPlaying = state == PlayerState.playing;
     notifyListeners();
   });
 }

  onDurationChanged() {
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });
  }

  onPositionChanged() {
    audioPlayer.onPositionChanged.listen((newPosition) {
        position = newPosition;
        notifyListeners();
    });
  }


}
