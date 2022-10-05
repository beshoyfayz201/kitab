import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kitab/data/data_sources/image_repo.dart';
import 'package:kitab/views/cubit/getbase_64.dart';
import 'package:meta/meta.dart';

part 'ocr_state.dart';

class OcrCubit extends Cubit<OcrState> {
  OcrCubit() : super(OcrInitial());
  static OcrCubit get(BuildContext context) => BlocProvider.of(context);
  File? pickedImage;
  String reslut = "";
  //
  pickImage(ImageSource imageSource) async {
    emit(OcrLoading());
    final img = await ImagePicker().pickImage(source: imageSource);
    if (img != null) {
      pickedImage = File(img.path);
      //covert to base64
      var img64 = getBase64Image(pickedImage!);
      emit(OcrImageLoaded());
      //send to api
      reslut = await imageToText(img64);
      emit(OcrSuccess());
    } else {
      reslut = "No image selected";
      emit(OcrSuccess());
    }
  }

  //copy to cliboard
  copy(BuildContext context) {
    if (reslut.isNotEmpty) {
      FlutterClipboard.copy(reslut).then((value) {
        print("object");
        Fluttertoast.showToast(msg: reslut);
      });
    } else {
      Fluttertoast.showToast(msg: "there is no text to copy");
    }
  }

  clear() {//to clear all Data
    if (pickedImage != null) {
      pickedImage = null;
      reslut = "";
            Fluttertoast.showToast(msg: "data is clear");

    }
  }
}
