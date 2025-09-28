import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screenshot/screenshot.dart';

import '../../application/cart_bloc/cart_bloc.dart';
import '../../application/share_cubit/share_cubit.dart';
import '../../configs/app.dart';
import '../../configs/configs.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../domain/entities/cart/cart_item.dart';
import '../../domain/entities/products/product.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/dots_indicator.dart';
import '../widgets/loading_shimmer.dart';
import '../widgets/photo_view_dialog.dart';
import '../widgets/quantity_row.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  PageController _pageController = PageController();
  ScrollController _listController = ScrollController();
  int _selectedPageIndex = 0;
  late double _selectedPriceTag;

  @override
  void initState() {
    super.initState();
    _selectedPriceTag = widget.product.Price;
    _pageController.addListener(() {
      setState(() {
        _selectedPageIndex = _pageController.page?.round() ?? 0;
        _listController.animateTo(
          _selectedPageIndex * 116.0,
          // Adjust this value based on your item width and margin
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    //bool isProductInWishlist =
    //context.read<WishlistCubit>().isInWishlist(widget.product.id);
    return Screenshot(
      controller: context.read<ShareCubit>().screenshotController,
      child: Scaffold(
        appBar: CustomAppBar("PRODUCT DETAILS", context,
            doesHasCartIcon: true, automaticallyImplyLeading: true),
        body: Padding(
          padding: Space.all(.9, .7),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.ProductName.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.h2b,
                ),
                Space.yf(.6),
                Text(
                  "${widget.product.Price} \$",
                  style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                ),
                Space.yf(.6),
                Row(
                  children: [
                    Text(
                      "Category Name : ",
                      style: AppText.h3,
                    ),
                    Text(
                      widget.product.Categories.first.CategoryName.toUpperCase(),
                      style: AppText.h3b?.copyWith(color: AppColors.CommonCyan),
                    ),
                  ],
                ),
                Space.yf(1.1),
                Stack(
                  children: [
                    Container(
                      height: AppDimensions.normalize(130),
                      color: AppColors.LightGrey,
                      padding: Space.all(0, 1),
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemCount: widget.product.Image.length,
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _selectedPageIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  showPhotoViewDialog(
                                      widget.product.Image[index], context);
                                },
                                child: Hero(
                                  tag: widget.product.ProductId,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.contain,
                                    imageUrl: widget.product.Image[index],
                                    placeholder: (context, url) =>
                                        placeholderShimmer(),
                                  ),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: AppDimensions.normalize(.1),
                            left: 0,
                            right: 0,
                            child: Dotsindicator(
                              dotsIndex: _pageController.hasClients
                                  ? _pageController.page?.round()
                                  : 0,
                              dotsCount: widget.product.Image.length,
                              activeColor: AppColors.CommonCyan,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: AppDimensions.normalize(50),
                  color: AppColors.LightGrey,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _listController,
                    itemCount: widget.product.Image.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          padding: Space.all(.2, .2),
                          decoration: BoxDecoration(
                            color: AppColors.LightGrey,
                            border: Border.all(
                              color: _selectedPageIndex == index
                                  ? AppColors
                                  .CommonCyan // Change this to your desired color
                                  : Colors.transparent,
                              width: 5.0,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.Image[index],
                            placeholder: (context, url) => placeholderShimmer(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: AppColors.LightGrey,
                  margin: Space.v,
                  padding: Space.all(.5, .5),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          /*isProductInWishlist*/false
                              ? GestureDetector(
                              onTap: () {
                                /*setState(() {
                                      context
                                          .read<WishlistCubit>()
                                          .removeFromWishlist(
                                              ProductModel.fromEntity(
                                                  widget.product));
                                    });*/
                              },
                              child: const Icon(Icons.favorite))
                              : GestureDetector(
                              onTap: () {
                                setState(() {

                                });
                              },
                              child: const Icon(Icons.favorite_border)),
                          Space.xf(.3),
                          Text(
                            "Add to wishlist",
                            style: AppText.h3,
                          )
                        ],
                      ),
                      Space.xf(.8),
                      Container(
                        height: AppDimensions.normalize(10),
                        width: 1,
                        color: Colors.grey,
                      ),
                      Space.xf(2.5),
                      GestureDetector(
                        onTap: () async {
                          context.read<ShareCubit>().shareScreenshot();
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AppAssets.Share,
                              height: AppDimensions.normalize(10),
                            ),
                            Space.xf(.7),
                            Text(
                              "Share",
                              style: AppText.h3,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Space.yf(1.2),
                Text(
                  "Description",
                  style: AppText.h3b,
                ),
                Space.yf(.5),
                Text(
                  widget.product.Description,
                  style:
                  AppText.b2?.copyWith(height: AppDimensions.normalize(.6)),
                ),
                Space.yf(1.2),
                Text(
                  "Prices",
                  style: AppText.h3b,
                ),
                Space.yf(.5),
                Text(
                  widget.product.Price.toString(),
                  style:
                  AppText.b2?.copyWith(height: AppDimensions.normalize(.6)),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.LightGrey,
          height: AppDimensions.normalize(33),
          padding: Space.all(.7, .9),
          margin: EdgeInsets.only(
              top: AppDimensions.normalize(1),
              bottom: AppDimensions.normalize(6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: QuantityRow(17, 2)),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartBloc>().add(
                      AddProduct(
                        cartItem: CartItem(
                          //need update-------------------------------------------------------------------------------
                            CartItemId: '2',
                            CartId: '2',
                            product: widget.product,
                            Quantity: 2),
                      ),
                    );
                    /*context.read<NotificationsCubit>().showAndSaveNotification(
                        "Cart Update",
                        "Congratulations, You have successfully added ${widget.product.name} to your cart.");
                    showPoceedtoCartBottomSheet(context);*/
                  },
                  child: Text(
                    "Add to cart",
                    style: AppText.h3b?.copyWith(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
