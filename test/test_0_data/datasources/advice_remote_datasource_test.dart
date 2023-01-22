import 'package:advicer/0_data/datasources/advice_remote_datasource.dart';
import 'package:advicer/0_data/models/advice_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  //*il 'group' + esterno mi dà il nome della classe che testo
  //* poi metto a ltri gruppi di test con le loro descrizioni
  group("AdviceRemoteDatasource", () {
    group("should return AdviceModel", () {
      test("when client response is 200 and has valid data", () async {
        //* uso Mocks che mimano la classe da testare o le classi dipendenze
        //*in questo test ho chiesto di creare una classe che facesse il mock di
        //* http.Client(nell'annotazione)
        //*con il mock posso fare finta che la risposta sia TOT, che ci siano errori, ecc...
        final mockClient = MockClient();
        //*creo istanza da testare passandogli il client finto (creato sulla base di quello vero)
        final adviceRemoteDataSourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        //*risposta FINTA che decido io
        const responseBody = '{"advice":"test_advice","advice_id": 1}';
        //*ora faccio esattamente come nella classe quando chiamo la get sull'endpointù
        //* ma uso WHEN e thenANSWER
        when(mockClient.get(
            Uri.parse(
              "https://api.flutter-community.com/api/v1/advice",
            ),
            headers: {
              //*additional info (API KEY etc content-type )
              'content-type': 'application/json'
            })).thenAnswer(//! qui sto MODIFICANDO la risposta
            //! sto dicendo: quando il client fa la get con questi parametri
            //! allora rispondi con una Future il cui valore è una http.Response
            //! con il body che mi sono creato prima e con lo status code 200
            (realInvocator) => Future.value(Response(responseBody, 200)));

        //! ora il test vero e proprio
        final result =
            await adviceRemoteDataSourceUnderTest.getRandomAdviceFromApi();
        //! qui la nostra datasource sotto test chiamerà il suo client che abbiamo "taroccato"
        //! e resituirà una risposta fake se tutto va bene avrò il mio modello
        expect(
            result,
            AdviceModel(
                advice: "test_advice", id: 1)); //STESSI DATI CHE MESSO NEL MOCK
      });
    });
  });
}
