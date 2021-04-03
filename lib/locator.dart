import 'package:get_it/get_it.dart';
import 'package:woke_out/model/authModel.dart';
import 'package:woke_out/model/baseModel.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => AuthModel());
}
