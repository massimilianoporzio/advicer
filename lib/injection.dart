import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/repositories/advice_repo_impl.dart';
import 'package:advicer/1_domain/usecases/advice_usecase.dart';
import 'package:advicer/2_application/pages/advice/cubit/advicer_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

import '1_domain/repositories/advice_repo.dart';

//*sl == Service Locator
final sl = GetIt.I;

Future<void> init() async {
  //*Registro
  //! application layer
  //Factory = every time a NEW/FERSH instance of the class
  //*sl() cerca se ho registrato qualcosa come useCase
  sl.registerFactory(() => AdvicerCubit(adviceUseCase: sl()));

  //! domain layer repo is registered we ask sl()
  sl.registerFactory(() => AdviceUseCase(adviceRepo: sl()));

  // ! data layer
  sl.registerFactory<AdviceRepo>(
      () => AdviceRepoImpl(adviceRemoteDataSource: sl()));
  sl.registerFactory<AdviceRemoteDataSource>(
      () => AdviceRemoteDataSourceImpl(client: sl()));

  //! externs /dai package
  sl.registerFactory(() => http.Client());
}
