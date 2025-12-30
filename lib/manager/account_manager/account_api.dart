

import 'package:app/main/config.dart';
import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:app/utility/http/http_manager.dart';
import 'package:app/utility/http/model/http_paging_data.dart';
import 'package:app/utility/http/model/http_response_data.dart';

class AccountApi {

  static Future<HttpResponseData<UserModel>> login({
    required String phone,
    required String password,
  }) async {
    return await HttpManager().requestPost(
      url: "/account/login",
      data: {
        "phone": phone,
        "password": password,
      },
      fromJsonT: (json) => UserModel.fromJson(json),
    );
  }

  static Future<HttpResponseData<List<UserModel>>> members() async {
    return await HttpManager().requestGet(
      url: "/account/members",
      fromJsonT: (json) => List<UserModel>.from(json.map(UserModel.fromJson)),
    );
  }

  static Future<HttpResponseData<HttpPagingData<UserModel>>> pageMembers({
    required int page,
    int size = HttpConfig.firstPageIndex,
  }) async {
    return await HttpManager().requestGet(
      url: "/account/members/list",
      query: {
        "page": page,
        "size": size,
      },
      fromJsonT: (json) => HttpPagingData.fromJson(json, (json) => UserModel.fromJson(json as Map<String, dynamic>)),
    );
  }
}
