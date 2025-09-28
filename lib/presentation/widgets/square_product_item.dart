
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../configs/app.dart';
import '../../core/app_router.dart';
import '../../core/constants/colors.dart';
import '../../domain/entities/products/product.dart';
import '../../configs/configs.dart';
import 'loading_shimmer.dart';

class SquareProductItem extends StatelessWidget {
  const SquareProductItem({super.key, this.product});

  final ProductEntity? product;

  @override
  Widget build(BuildContext context) {
    //-----------------------------------need check-----------------
    App.init(context);
    //--------------------------------------------------------------
    return product != null
        ? Padding(
      padding: EdgeInsets.only(right: AppDimensions.normalize(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.of(context).pushNamed(AppRouter.productDetails, arguments: product);
            },
            child: Container(
              decoration:
              BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Hero(
                tag:product!.ProductId ,
                child: CachedNetworkImage(
                  height: AppDimensions.normalize(70),
                  width: AppDimensions.normalize(70),
                  imageUrl: product!.Image.last,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => placeholderShimmer(),
                  errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
          ),
          Space.y1!,
          SizedBox(
            width: AppDimensions.normalize(60),
            child: Text(
              product!.ProductName.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.h2b?.copyWith(color: AppColors.GreyText),
            ),
          )
        ],
      ),
    )
        : LoadingShimmer(isSquare: true);
  }
}
