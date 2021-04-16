import 'package:get_it/get_it.dart';
import 'package:woke_out/model/base_model.dart';
import 'package:woke_out/services/auth_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => AuthService());
}
