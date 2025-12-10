
import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:app/utility/http/http_manager.dart';
import 'package:app/utility/http/model/http_paging_data.dart';
import 'package:app/utility/http/model/http_response_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'http_api.g.dart';

final HttpApi httpApi = HttpApi(HttpManager().dio);

@RestApi()
abstract class HttpApi {
  factory HttpApi(Dio dio, {String? baseUrl}) = _HttpApi;

  @POST("/baby/create")
  Future<HttpResponseData<UserModel>> createBaby(
    @Field() String name,
  );

  @GET("/baby/list")
  Future<HttpResponseData<List<UserModel>>> getBabyList();

  @GET("/baby/list/page")
  Future<HttpResponseData<HttpPagingData<UserModel>>> getBabyListPage(
    @Query("pageIndex") int pageIndex,
    @Query("pageSize") int pageSize,
  );

}
