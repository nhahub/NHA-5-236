import 'package:flutter_bloc/flutter_bloc.dart';

part '<FTName | snakecase>_event.dart';
part '<FTName | snakecase>_state.dart';

class <FTName | pascalcase>Bloc extends Bloc<<FTName | pascalcase>Event, <FTName | pascalcase>State> {
  <FTName | pascalcase>Bloc() : super(<FTName | pascalcase>Initial()) {
    on<<FTName | pascalcase>Event>(_onEvent);
  }

  void _onEvent(<FTName | pascalcase>Event event, Emitter<<FTName | pascalcase>State> emit) {
    emit(<FTName | pascalcase>Initial());
  }
}