part of '<FTName | snakecase>_bloc.dart';

abstract class <FTName | pascalcase>State {}

class <FTName | pascalcase>Initial extends <FTName | pascalcase>State {}

class <FTName | pascalcase>StateError extends <FTName | pascalcase>State {
  final String message;
  <FTName | pascalcase>StateError({required this.message});
}