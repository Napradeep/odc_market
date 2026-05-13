import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_event.dart';
import 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final SharedPreferences prefs;
  static const String _languageKey = 'is_english_language';

  LanguageBloc({required this.prefs}) : super(const LanguageState(isEnglish: true)) {
    on<LoadLanguage>((event, emit) {
      final isEnglish = prefs.getBool(_languageKey) ?? true;
      emit(LanguageState(isEnglish: isEnglish));
    });

    on<ToggleLanguage>((event, emit) async {
      final newLanguage = !state.isEnglish;
      await prefs.setBool(_languageKey, newLanguage);
      emit(LanguageState(isEnglish: newLanguage));
    });
  }
}
