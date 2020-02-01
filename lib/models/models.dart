import 'package:flutter/foundation.dart';

/// Note: there is no toMap or fromMap method, it's just data class without
/// any logic inside !!! 
/// We prefer using the adapter pattern to adapt our database object to these 
/// object models.
/// These adapters are in the repository that handle source data
/// It is more flexible and maintenable as we wan change our repository 
/// (structure, platform, etc.) as we want, it do not affect our models (because 
/// he doesn't have to)


/// Represents a theme
class QuizTheme {
  String id;
  String title;
  String entitled;
  String icon;
  int color;
}


/// Represtents a question
class QuizQuestion {
  String id;
  QuizTheme theme;
  Resource entitled;
  List<QuizAnswer> answers;
  int difficulty;
}

/// A resource is made of the actual resource content ([resource]) and its 
/// [type]
class Resource {
  String resource;
  ResourceType type;

  Resource({@required this.resource, @required this.type});
}

///
class QuizAnswer {
  Resource answer;
  bool isCorrect;

  QuizAnswer({@required this.answer, this.isCorrect = false});
}


/// Supported ressource type
enum ResourceType {
  TEXT,
  IMAGE,
  LOCATION,
}