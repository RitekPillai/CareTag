import 'package:flutter_bloc/flutter_bloc.dart';

part 'diagonostic_state.dart';
part 'diagonostic_event.dart';

class DiagonosticBloc extends Bloc<DiagonosticEvent, DiagonosticState> {
  DiagonosticBloc(super.initialState);
}
