import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavamart/presentation/widgets/payment_details_row.dart';
import 'package:lavamart/presentation/widgets/transparent_button.dart';

import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/order_add_cubit/order_add_cubit.dart';
import '../../configs/configs.dart';
import '../../core/app_router.dart';
import '../../core/constants/colors.dart';
import '../../domain/entities/orders/order.dart';
import 'auth_check_modalsheet.dart';
import 'dashed_separator.dart';


class PaymentDetails extends StatefulWidget {
  const PaymentDetails(
      {super.key,
        required this.buttonText,
        required this.isFromCheckout,
        required this.isLogged});

  final String buttonText;
  final bool isFromCheckout;
  final bool isLogged;

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.cart.isEmpty) {
          return const SizedBox.shrink();
        }
        Widget paymentWidget = Container(
          color: AppColors.LightGrey,
          padding: Space.all(1, 1.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PAYMENT DETAILS",
                style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
              ),
              Space.yf(),
              PaymentDetailsRow(
                  "SUB Total",
                  '${state.cart.fold(0.0, (previousValue, element) => (element.product.Price + previousValue))}',
                  null),
              PaymentDetailsRow("Gift Charges", '0.000', null),
              PaymentDetailsRow("Discount", '0.000', null),
              PaymentDetailsRow("Shipping Charges", '5.000', null),
              PaymentDetailsRow(
                  "Total",
                  '${state.cart.fold(0.0, (previousValue, element) => (element.product.Price + previousValue)) + 5}',
                  AppText.h3b),
              const DashedSeparator(),
              Space.yf(.8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    widget.isFromCheckout ? null : widget.isLogged
                        ? Navigator.pushNamed(context, AppRouter.checkout, arguments: state.cart)
                        : showAuthCheckModalSheet(context);
                  },
                  child: Text(
                    widget.buttonText,
                    style: AppText.h3b?.copyWith(color: Colors.white),
                  ),
                ),
              ),
              widget.isFromCheckout ? BlocListener<OrderAddCubit, OrderAddState>(
                listener: (context, state) {
                  if (state is OrderAddLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  } else if (state is OrderAddSuccess) {
                    //   context.read<CartBloc>().add(const ClearCart());
                    Navigator.of(context).pushNamed(AppRouter.ordersuccess);
                  } else if (state is OrderAddFail) {
                    Navigator.of(context).pushNamed(AppRouter.orderfailure);
                  }
                },
                child: Padding(
                  padding: Space.vf(1.5),
                  child: transparentButton(
                      context: context,
                      onTap: () {/*
                          context.read<OrderAddCubit>().addOrder(
                             OrderDetails(
                                  OrderId: state,
                                  Id: '',
                                  OrderDate:'',
                                  Status: '',
                                  TotalAmount:1,
                                  ShippingAddress: ''));
                     */ },
                      buttonText:
                      isLoading ? "Wait..." : "Pay On Delivery(in development)"),
                ),
              )
                  : const SizedBox.shrink()
            ],
          ),
        );
        return widget.isFromCheckout
            ? paymentWidget
            : Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: paymentWidget,
        );
      },
    );
  }
}
