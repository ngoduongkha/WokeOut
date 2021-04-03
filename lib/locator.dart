import 'package:get_it/get_it.dart';
import 'package:woke_out/model/homeModel.dart';
import 'package:woke_out/model/loginModel.dart';
import 'package:woke_out/model/baseModel.dart';
import 'package:woke_out/model/signupModel.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => LoginModel());
  locator.registerLazySingleton(() => SignupModel());
  locator.registerLazySingleton(() => HomeModel());
}
