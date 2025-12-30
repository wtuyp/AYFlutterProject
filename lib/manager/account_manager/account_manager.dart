

import 'dart:convert';

import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:app/utility/common/sp_util.dart';

class AccountManagerKey {
  static const String accessToken = "account.token.access";
  static const String refreshToken = "account.token.refresh";
  static const String userInfo = "account.info";
}

/// 账户管理类
class AccountManager {
  static final AccountManager _instance = AccountManager._internal();
  factory AccountManager() => _instance;

  AccountManager._internal();

  Future<void> loadData() async {
    accessToken = await SpUtil.getString(AccountManagerKey.accessToken);
    refreshToken = await SpUtil.getString(AccountManagerKey.refreshToken);

    String? userInfoJson = await SpUtil.getString(AccountManagerKey.userInfo);
    if (userInfoJson != null) {
      _accountInfoModel = UserModel.fromJson(jsonDecode(userInfoJson));
    }
  }

  // 账户信息
  UserModel? _accountInfoModel;

  UserModel? get accountInfoModel => _accountInfoModel;
  set accountInfoModel(UserModel? accountInfoModel) {
    _accountInfoModel = accountInfoModel;
    if (accountInfoModel != null) {
      SpUtil.setString(AccountManagerKey.userInfo, jsonEncode(accountInfoModel.toJson()));
    } else {
      SpUtil.remove(AccountManagerKey.userInfo);
    }
  }

  // 访问令牌 和 刷新令牌
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  set accessToken(String? token) {
    _accessToken = token;
    if (token != null) {
      SpUtil.setString(AccountManagerKey.accessToken, token);
    } else {
      SpUtil.remove(AccountManagerKey.accessToken);
    }
  }

  set refreshToken(String? token) {
    _refreshToken = token;
    if (token != null) {
      SpUtil.setString(AccountManagerKey.refreshToken, token);
    } else {
      SpUtil.remove(AccountManagerKey.refreshToken);
    }
  }

  bool get isLogin => _accessToken != null;

  void clear() {
    accessToken = null;
    refreshToken = null;
    accountInfoModel = null;
  }

  void requestAccountInfo() async {
    if (isLogin) {
      // TODO: 发送请求获取账户信息
      // 假设请求成功，返回账户信息模型
      UserModel accountInfoModel = UserModel();
      // 更新账户信息
      this.accountInfoModel = accountInfoModel;
    }
  }

  void requestLogout() async {
    if (isLogin) {
      // TODO: 发送请求注销账户
      // 假设请求成功，清空账户信息
      clear();
    }
  }
}
