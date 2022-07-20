import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow/common/popup.dart';
import 'package:rainbow/model/StoryComment_model.dart';
import 'package:rainbow/service/http_services.dart';
import 'package:rainbow/service/pref_services.dart';
import 'package:rainbow/utils/end_points.dart';
import 'package:rainbow/utils/pref_keys.dart';

class StoryCommentApi {
  static Future postRegister(String id,String des) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.commentStory;

      Map<String, String> param = {   "id_story" : id.toString(),
        "description" : des};
      print(param);
      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {
            "Content-Type": "application/json",
            "x-access-token": accesToken
          });
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          flutterToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return storyCommentModelFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}