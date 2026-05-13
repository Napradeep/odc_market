import 'package:equatable/equatable.dart';

class LanguageState extends Equatable {
  final bool isEnglish;

  const LanguageState({this.isEnglish = true});

  @override
  List<Object> get props => [isEnglish];
}
