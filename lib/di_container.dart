import 'package:chocsarayi/theme_provider.dart';
import 'package:dio/dio.dart';
import 'package:chocsarayi/data/repository/banner_repo.dart';
import 'package:chocsarayi/data/repository/cart_repo.dart';
import 'package:chocsarayi/data/repository/category_repo.dart';
import 'package:chocsarayi/data/repository/chat_repo.dart';
import 'package:chocsarayi/data/repository/coupon_repo.dart';
import 'package:chocsarayi/data/repository/location_repo.dart';
import 'package:chocsarayi/data/repository/notification_repo.dart';
import 'package:chocsarayi/data/repository/order_repo.dart';
import 'package:chocsarayi/data/repository/product_repo.dart';
import 'package:chocsarayi/data/repository/language_repo.dart';
import 'package:chocsarayi/data/repository/onboarding_repo.dart';
import 'package:chocsarayi/data/repository/search_repo.dart';
import 'package:chocsarayi/data/repository/set_menu_repo.dart';
import 'package:chocsarayi/data/repository/profile_repo.dart';
import 'package:chocsarayi/data/repository/splash_repo.dart';
import 'package:chocsarayi/data/repository/wishlist_repo.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'onboarding_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient('', sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => CategoryRepo(dioClient: sl()));
  sl.registerLazySingleton(() => BannerRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProductRepo(dioClient: sl()));
  sl.registerLazySingleton(() => OnBoardingRepo(dioClient: sl()));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LocationRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SetMenuRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => WishListRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
  // sl.registerFactory(() => CategoryProvider(categoryRepo: sl()));
  // sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  // sl.registerFactory(() => ProductProvider(productRepo: sl()));
  // sl.registerFactory(() => CartProvider(cartRepo: sl()));
  // sl.registerFactory(() => OrderProvider(orderRepo: sl()));
  // sl.registerFactory(() => ChatProvider(chatRepo: sl()));
  // sl.registerFactory(() => AuthProvider());
  // sl.registerFactory(() => LocationProvider(sharedPreferences: sl(), locationRepo: sl()));
  // sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  // sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  // sl.registerFactory(() => SetMenuProvider(setMenuRepo: sl()));
  // sl.registerFactory(() => WishListProvider(wishListRepo: sl(), productRepo: sl()));
  // sl.registerFactory(() => CouponProvider(couponRepo: sl()));
  // sl.registerFactory(() => SearchProvider(searchRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
