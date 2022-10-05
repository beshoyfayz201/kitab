import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'package:kitab/views/cubit/ocr_cubit.dart';

class HomePage extends StatelessWidget {
  openDialoge(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(_);
              await OcrCubit.get(context).pickImage(ImageSource.gallery);
            },
            child: Text("Gallery"),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(_);
              await OcrCubit.get(context).pickImage(ImageSource.camera);
            },
            child: Text("Camera"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(_);
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    showToast() {
      Fluttertoast.showToast(msg: "copied");
    }

    return BlocProvider<OcrCubit>(
      create: (context) => OcrCubit(),
      child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            title: Text('Kitab'),
          ),
          floatingActionButton: BlocBuilder<OcrCubit, OcrState>(
            builder: (context, state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FloatingActionButton(
                    heroTag: "FloatingActionButtonTag",
                    onPressed: () {
                      OcrCubit.get(context).copy(context);
                    },
                    child: Icon(Icons.copy),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  FloatingActionButton(
                    backgroundColor: Colors.red,
                    heroTag: "FloatingActionButtonTag",
                    onPressed: () {
                      OcrCubit.get(context).clear();
                    },
                    child: Icon(Icons.replay),
                  ),
                ],
              );
            },
          ),
          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: BlocBuilder<OcrCubit, OcrState>(
                    builder: (context, state) {
                      if (state is OcrError) {}
                      return state is OcrLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InkWell(
                              onTap: () {
                                return openDialoge(context);
                              },
                              child: OcrCubit.get(context).pickedImage == null
                                  ? Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 100,
                                    )
                                  : Image.file(
                                      OcrCubit.get(context).pickedImage!,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.fill,
                                    ));
                    },
                  ),
                ),
                BlocBuilder<OcrCubit, OcrState>(builder: (context, state) {
                  return state is OcrImageLoaded
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                          OcrCubit.get(context).reslut,
                        );
                })
              ]),
            ),
          )),
    );
  }
}
