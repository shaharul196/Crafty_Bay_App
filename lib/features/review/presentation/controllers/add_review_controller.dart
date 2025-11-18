import 'package:get/get.dart';
import '../../../../app/urls.dart';
import '../../../../core/models/network_response.dart';
import '../../../../core/services/network_caller.dart';
import '../data/models/add_review_model.dart';

class AddReviewController extends GetxController {
  bool _addReviewInProgress = false;
  String? _errorMessage;
  String? _responseBody;

  bool get addReviewInProgress => _addReviewInProgress;
  String? get errorMessage => _errorMessage;
  String? get responseBody => _responseBody;

  Future<bool> getAddReview(AddReviewModel model,) async {
    bool isSuccess = false;
    _addReviewInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addReviewUrl, body: model.toJson());

    if (response.isSuccess) {
      _responseBody = response.body!['data']['product'];
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.body!['msg'] ?? response.errorMassage;
    }

    _addReviewInProgress = false;
    update();
    return isSuccess;
  }
}
