import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/utils/constants.dart';
import '../controllers/cart_list_controller.dart';


class TotalPriceAndCheckoutSection extends StatelessWidget {
  const TotalPriceAndCheckoutSection({super.key});

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
                'Total Price',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GetBuilder<CartListController>(
                builder: (controller) {
                  return Text(
                    '$takaSign${controller.totalPrice}',
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.themeColor,
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(
            width: 120,
            child: FilledButton(onPressed: () {
              _sslEcommercePaymentGateway();
            }, child: Text('Checkout')),
          ),
        ],
      ),
    );
  }

  Future<void> _sslEcommercePaymentGateway() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //   ipn_url: "www.ipnurl.com",
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: "ostad68f47b9a1f3cd",
        store_passwd: "ostad68f47b9a1f3cd@ssl",
        total_amount: 1.00,
        tran_id: "custom_transaction_id",
      ),
    );

    final response = await sslcommerz.payNow();

    if(response.status == 'VALID'){
      print('Payment successfully');
      print('TxID: ${response.tranId}');
      print('TxDate: ${response.tranDate}');

    }
    if(response.status == 'Closed'){

    }
    if(response.status == 'FAILED'){
      print('Your payment is failed');

    }
   
  }
}
