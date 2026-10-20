import 'package:flutter_bloc/flutter_bloc.dart';
part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc() : super(RootInitial()) {
    on<ChangeIndexRootEvent>(_onChangeIndexRootEvent);
  }

  void _onChangeIndexRootEvent(
    ChangeIndexRootEvent event,
    Emitter<RootState> emit,
  ) {
    emit(ChangeIndexRootState(index: event.index));
  }
}
