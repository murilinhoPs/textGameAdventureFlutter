import "package:flutter_test/flutter_test.dart";
import 'package:mockito/mockito.dart';
import 'package:text_adventure_app/app/shared/services/save_json.dart';

class MockRepository extends Mock implements JsonDataLocal {}

main() async {
  final repository = MockRepository();

  group("test saving and reading json locally", () {
    test("Returns json to model", () async {
      when(await repository.saveHistoryInPrefs())
          .thenReturn(repository.adventureModel);
    });

    test("Returns json saved", () async {
      await repository.saveHistoryInPrefs();

      when(await repository.getHistoryFromPrefs())
          .thenReturn(repository.adventureModel);
    });
  });
}
