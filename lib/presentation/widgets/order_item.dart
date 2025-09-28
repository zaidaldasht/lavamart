import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../configs/configs.dart';
import '../../core/constants/colors.dart';
import '../../domain/entities/cart/cart.dart';
import '../../domain/entities/cart/cart_item.dart';
import '../../domain/entities/orders/order.dart';
import 'dashed_separator.dart';
import 'loading_shimmer.dart';


class OrderItemWidget extends StatelessWidget {
  final OrderDetails? orderDetails;
  final Cart? cart;

  const OrderItemWidget({Key? key, this.orderDetails, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (orderDetails != null) {
      return Padding(
        padding: Space.v!,
        child: DottedBorder(
          child: Container(
            padding: Space.all(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Order ID : ",
                            style: AppText.h3
                                ?.copyWith(color: AppColors.GreyText)),
                        Text(
                          orderDetails!.OrderId,
                          style: AppText.h3b,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    Space.y1!,
                    Padding(
                      padding: Space.hf(.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Order Items",
                                  style: AppText.h3
                                      ?.copyWith(color: AppColors.GreyText)),
                              Space.yf(.2),
                              Text(
                                "${cart!.items.length}",
                                style: AppText.h3b,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Order Price",
                                style: AppText.h3
                                    ?.copyWith(color: AppColors.GreyText),
                              ),
                              Space.yf(.2),
                              Text(
                                "${cart!.items.fold(0.0, (previousValue, element) => (previousValue + (element.product.Price * element.Quantity)))}",
                                style: AppText.h3b,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Space.yf(),
                const DashedSeparator(),
                Space.yf(),
                Column(
                  children: cart!.items
                      .map((cartitem) => Padding(
                    padding: EdgeInsets.only(
                        bottom: AppDimensions.normalize(2)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: AppDimensions.normalize(35),
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.normalize(5)),
                                child: Padding(
                                  padding: Space.all(),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    cartitem.product.Image.first,
                                  ),
                                )),
                          ),
                        ),
                        Space.xf(1.2),
                        Flexible(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                cartitem.product.ProductName,
                                style: AppText.b1b,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                              Space.yf(.5),
                              Text(
                                '\$${cartitem.product.Price.toStringAsFixed(2)}',
                                style: AppText.b1b?.copyWith(
                                    color: AppColors.CommonCyan),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return LoadingShimmer(isSquare: false);
    }
  }
}
