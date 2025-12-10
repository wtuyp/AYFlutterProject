

import 'package:app/manager/account_manager/account_api.dart';
import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:app/model/data_state.dart';
import 'package:app/utility/http/model/http_exception.dart';
import 'package:app/utility/http/model/http_paging_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends Notifier<DataState<HttpPagingData<UserModel>>> {

  @override
  DataState<HttpPagingData<UserModel>> build() {
    return DataState(data: HttpPagingData<UserModel>());
  }

  List<UserModel> get members => state.data!.pageData;

  Future<void> fetchMembers({
    bool refresh = false,
  }) async {
    try {
      final page = refresh ? state.data!.firstPage : state.data!.nextPage;
      final response = await AccountApi.pageMembers(
        page: page,
      );

      if (response.isSuccess) {
        final pageData = refresh ? response.data?.pageData ?? List<UserModel>.empty() : [...state.data!.pageData, ...response.data?.pageData ?? List<UserModel>.empty()];
        final HttpPagingData<UserModel> pagingData = HttpPagingData<UserModel>(
          pageIndex: page,
          pageTotal: 10,
          pageData: pageData,
        );
        state = state.copyWith(
          data: pagingData,
        );
      }
    } on HttpException catch (e) {
      print(e);
    }
  }
}

final userNotifierProvider = NotifierProvider<UserNotifier, DataState<HttpPagingData<UserModel>>>(UserNotifier.new);
