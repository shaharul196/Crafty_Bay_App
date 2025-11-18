import 'package:get/get.dart';

import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../../../shared/data/models/product_details_model.dart';


class ProductDetailsController extends GetxController {
  bool _getProductDetailsInProgress = false;
  ProductDetailsModel? _productDetailsModel;
  String? _errorMessage;

  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  ProductDetailsModel? get productDetailsModel => _productDetailsModel;

  String? get errorMessage => _errorMessage;

  Future<bool> getProductDetails(String productId) async {
    bool isSuccess = false;
    _getProductDetailsInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.productDetailsUrl(productId),
    );
    if (response.isSuccess) {
      _productDetailsModel = ProductDetailsModel.fromJson(
        response.body!['data'],
      );
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMassage;
    }

    _getProductDetailsInProgress = false;
    update();

    return isSuccess;
  }
}
