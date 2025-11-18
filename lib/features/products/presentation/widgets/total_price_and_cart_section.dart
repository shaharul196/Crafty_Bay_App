import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/controllers/authentication_controller.dart';
import '../../../../app/utils/constants.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../../shared/data/models/product_details_model.dart';
import '../../../shared/presentation/widgets/centered_circular_progress.dart';
import '../../../shared/presentation/widgets/snackbar_message.dart';
import '../controllers/add_to_cart_controller.dart';


class TotalPriceAndCartSection extends StatefulWidget {
  const TotalPriceAndCartSection({super.key, required this.productDetailsModel,});

  final ProductDetailsModel productDetailsModel;

  @override
  State<TotalPriceAndCartSection> createState() => _TotalPriceAndCartSectionState();
}

class _TotalPriceAndCartSectionState extends State<TotalPriceAndCartSection> {
  final AddToCartController _addToCartController = AddToCartController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.themeColor.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$takaSign${widget.productDetailsModel.currentPrice}',
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.themeColor,
                ),
              ),
            ],
          ),
          GetBuilder(
            init: _addToCartController,
            builder: (controller) {
              return SizedBox(
                width: 120,
                child: Visibility(
                  visible: controller.addToCartInProgress == false,
                  replacement: CenteredCircularProgress(),
                  child: FilledButton(onPressed: () {
                    _onTapAddToCardButton();
                  }, child: Text('Add to Cart')),
                ),
              );
            }
          ),
        ],
      ),
    );
  }

  void _onTapAddToCardButton() async{
    if(await Get.find<AuthenticationController>().isUserAlreadyLoggedIn()){
    // TODO Add to card
      final bool isSuccess = await _addToCartController.getAddToCard(
          widget.productDetailsModel.id);
      if(isSuccess){
        shownSnackBarMessage(context, 'Added to cart');
      }else{
        shownSnackBarMessage(context, _addToCartController.errorMessage!);
      }

    }else {
      Navigator.pushNamed(context, SignInScreen.name);
    }

  }
}
