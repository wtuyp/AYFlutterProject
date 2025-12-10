


import 'package:app/manager/account_manager/account_info_model.dart';
import 'package:app/utility/http/model/http_paging_data.dart';
import 'package:app/utility/http/model/http_response_data.dart';
import 'package:flutter/material.dart';

class JsonModelDemoPage extends StatefulWidget {
  const JsonModelDemoPage({super.key});

  @override
  State<JsonModelDemoPage> createState() => _JsonModelDemoPageState();
}

class _JsonModelDemoPageState extends State<JsonModelDemoPage> {

  @override
  void initState() {
    super.initState();
    jsonTest();
  }

  void jsonTest() {
    var json = {
      "code": 200,
      "message": "Success",
      "data": {"name": "John Doe"}
    };

    // 将 JSON 解析为 ApiResponse 对象
    var response = HttpResponseData<UserModel>.fromJson(
        json, (json) => UserModel.fromJson(json as Map<String, dynamic>));

    print(response);

    // 将 ApiResponse 对象转换为 JSON
    var jsonResponse = response.data?.toJson();
    print(jsonResponse);

    json = {
      "current": 1,
      "pages": 10,
      "records": [{"name": "Doe Doe"}, {"name": "Jane Jane"}]
    };

    // 将 JSON 解析为 HttpPagingData 对象
    var pagingResponse = HttpPagingData<UserModel>.fromJson(
        json, (json) => UserModel.fromJson(json as Map<String, dynamic>));

    print(pagingResponse);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Json Model Demo'),
      ),
      body: const Center(
        child: Text('Json Model Demo Page'),
      ),
    );
  }
}
