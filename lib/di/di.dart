import 'package:get_it/get_it.dart';
import 'package:lavamart/di/product.dart';
import 'package:lavamart/di/user.dart';

import 'cart.dart';
import 'category.dart';
import 'common.dart';
import 'cubits.dart';
import 'order.dart';

final sl = GetIt.instance;

// Main Initialization
Future<void> init() async {
  // Register features
  registerCategoryFeature();
  registerProductFeature();
  registerUserFeature();
  registerCartFeature();
  registerOrderFeature();

  // Register Cubits
  registerCubits();

  // Register common dependencies
  registerCommonDependencies();
}
