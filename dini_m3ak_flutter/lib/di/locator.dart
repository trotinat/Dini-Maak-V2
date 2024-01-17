import 'package:dini_maak/data/remote/auth_service.dart';
import 'package:dini_maak/data/remote/car_service.dart';
import 'package:dini_maak/data/remote/trip_servoice.dart';
import 'package:dini_maak/data/remote/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> initDi() async {
  final pref = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => CarService());
  locator.registerLazySingleton(() => TripService());
  locator.registerLazySingleton<SharedPreferences>(() => pref);
  locator.registerLazySingleton<UserService>(() => UserService());
}
