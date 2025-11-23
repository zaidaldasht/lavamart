import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/constants/api.dart';
import '../../../core/error/exceptions.dart';
import '../../models/products/filter_params_model.dart';
import '../../models/products/product_response_model.dart';



abstract class ProductRemoteDataSource {
  Future<ProductResponseModel> getProducts(FilterProductParams params);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  ProductRemoteDataSourceImpl({required this.client});
  @override
  Future<ProductResponseModel> getProducts(params) async {
    final keywordParam = Uri.encodeComponent(params.keyword ?? '');
    final pageParam = (params.limit != null && params.limit! > 0) ? params.limit! : 1;
    final pageSizeParam = params.pageSize ?? 10;

    String categoriesQuery = '';
    if (params.categories != null && params.categories.isNotEmpty) {
      categoriesQuery = params.categories
          .map((e) => 'Categories=${e.CategoryId}')
          .join('&');
    }

    final url =
        '$baseUrl/lavamart/Products/getProducts?keyword=$keywordParam&pageSize=$pageSizeParam&page=$pageParam${categoriesQuery.isNotEmpty ? '&$categoriesQuery' : ''}';

    print('Request URL: $url');

    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return productResponseModelFromJson(response.body);
    } else {
      print('Request failed: ${response.statusCode} ${response.body}');
      throw ServerException();
    }
  }

}
