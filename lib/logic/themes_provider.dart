import 'package:app/models/models.dart';
import 'package:app/repositories/local_database_repository.dart';
import 'package:flutter/widgets.dart';


class ThemesProvider extends ChangeNotifier {

  final ILocalDatabaseRepository _localRepo;

  List<QuizTheme> themes;
  var state = ThemeProviderState.not_init;


  ThemesProvider({
    @required ILocalDatabaseRepository localRepo
  }) : _localRepo = localRepo;


  loadThemes() async {
    state = ThemeProviderState.not_init;
    try {
      themes = await _localRepo.getThemes();
    } catch(_) {
      state = ThemeProviderState.error;
    }
    state = ThemeProviderState.init;
    notifyListeners();
  }
}


enum ThemeProviderState {
  not_init,
  init,
  error,
}