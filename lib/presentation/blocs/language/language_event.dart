import 'package:equatable/equatable.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ToggleLanguage extends LanguageEvent {}
class LoadLanguage extends LanguageEvent {}
