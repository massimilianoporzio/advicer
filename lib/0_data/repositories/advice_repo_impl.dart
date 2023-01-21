import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/exceptions/exceptions.dart';
import 'package:advicer/1_domain/failures/failures.dart';
import 'package:advicer/1_domain/entities/advice_entity.dart';
import 'package:advicer/1_domain/repositories/advice_repo.dart';
import 'package:dartz/dartz.dart';

//*implementazione del repo che chiama REMOTE e/o LOCAL datasources
//*logica per vedere se c'è cache, se c'è internet e orchestrare l'uso
//*delle datasources.
class AdviceRepoImpl implements AdviceRepo {
  //usa la remoteDS!
  // final AdviceRemoteDataSource adviceRemoteDataSource =
  //     AdviceRemoteDataSourceImpl();
  //*USO DEP JINJECTION
  final AdviceRemoteDataSource adviceRemoteDataSource;

  AdviceRepoImpl({required this.adviceRemoteDataSource});

  @override
  Future<Either<Failure, AdviceEntity>> getAdviceFromDataSource() async {
    //*chiamo la remote datasource
    //*try catch e in base all'eccezione ritorno una Failure
    try {
      final result = await adviceRemoteDataSource.getRandomAdviceFromApi();
      return right(result);
    } on ServerException catch (e) {
      // TODO_ RETURN FAILURES
      return left(ServerFailure());
    } on CacheException catch (e) {
      return left(CacheFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
//*vado sicuro sulla right al momento
  }
}
