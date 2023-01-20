abstract class Failure {}

class ServerFailure extends Failure {
} //*qualcosa in errore con API calls on servers outside the phone

class CacheFailure extends Failure {
} //* saving the data on the phone or reading from the phone

class GeneralFailure extends Failure {} //*tutti gli altri tipi