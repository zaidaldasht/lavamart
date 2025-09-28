


import '../application/bottom_navbar_cubit/bottom_navbar_cubit.dart';
import '../application/filter_cubit/filter_cubit.dart';
import '../application/share_cubit/share_cubit.dart';
import 'di.dart';

void registerCubits() {
  // Navigation
  sl.registerFactory(() => NavigationCubit());

  //Filter
  sl.registerFactory(() => FilterCubit());

  //Wishlist
  //sl.registerFactory(() => WishlistCubit());

  //Wishlist
  sl.registerFactory(() => ShareCubit());

  //Notiications
  //sl.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  //sl.registerFactory(() => NotificationsCubit(sl()));
}
