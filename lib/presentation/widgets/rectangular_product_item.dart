
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/app_router.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../configs/configs.dart';
import '../../domain/entities/products/product.dart';
import 'loading_shimmer.dart';


class RectangularProductItem extends StatelessWidget {
  final ProductEntity? product;
  final Function? onClick;
  final bool isFromWishlist;

  const RectangularProductItem({
    Key? key,
    this.product,
    this.onClick,
    this.isFromWishlist = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return product == null ? LoadingShimmer(isSquare: true) : buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRouter.productDetails, arguments: product);
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(bottom: AppDimensions.normalize(10.8)),
        child: Padding(
          padding: isFromWishlist ? Space.all(.5, .5) : Space.all(1, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product!.ProductId,
                child: product!.Image.isNotEmpty
                    ? CachedNetworkImage(
                  height: AppDimensions.normalize(70),
                  imageUrl: isFromWishlist
                      ? product!.Image.last
                      : product!.Image.first,
                  placeholder: (context, url) => placeholderShimmer(),
                  errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
                )
                    : SvgPicture.asset(
                  AppAssets.lvmartIcon,
                  height: AppDimensions.normalize(70),
                ),
              ),
              Space.y1!,
              Text(
                product!.ProductName,
                style: AppText.h3b,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Space.y!,
              product!.Price !=0
                  ? Text(
                r'$ ' + product!.Price.toString(),
                style: AppText.h3?.copyWith(
                  color: AppColors.CommonCyan,
                ),
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}