import 'dart:convert';
import 'package:kitab/core/utils/app_consts.dart';
import 'package:http/http.dart' as http;
import 'package:kitab/core/utils/end_points.dart';

Future imageToText(String img64) async {
  var data = {"base64Image": img64};
  
  var header = {"apikey": AppConsts.apiKey};
  http.Response response = await http.post(Uri.parse(EndPoints.sendImage),
      body: data, headers: header);
  //get data
  Map res = jsonDecode(response.body);
  
  return
  (res["OCRExitCode"]==1)?
   res["ParsedResults"][0]["ParsedText"]
  :"sorry\n"+res["ErrorMessage"][0].toString();
}
