
import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:app/utility/http/http_manager.dart';
import 'package:app/utility/http/model/http_paging_data.dart';
import 'package:app/utility/http/model/http_response_data.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'http_api.g.dart';

final HttpApi httpApi = HttpApi();

@RestApi()
abstract class HttpApi {
  // factory HttpApi(Dio dio, {String? baseUrl}) = _HttpApi;

  factory HttpApi({Dio? dio, String? baseUrl}) {
    dio ??= HttpManager().dio;
    return _HttpApi(dio, baseUrl: baseUrl);
  }

  @POST("/account/login")
  Future<HttpResponseData<UserModel>> login({
    @Field() required String phone,
    @Field() required String password,
  });

  @GET("/account/members")
  Future<HttpResponseData<List<UserModel>>> members();

  @GET("/account/members/list")
  Future<HttpResponseData<HttpPagingData<UserModel>>> pageMembers(
    @Query("page") int pageIndex,
    @Query("size") int pageSize,
  );
}
