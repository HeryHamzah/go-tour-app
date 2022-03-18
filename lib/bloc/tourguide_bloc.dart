import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tourguide_event.dart';
part 'tourguide_state.dart';

class TourguideBloc extends Bloc<TourguideEvent, TourguideState> {
  TourguideBloc() : super(TourguideInitial());

  @override
  Stream<TourguideState> mapEventToState(
    TourguideEvent event,
  ) async* {
    throw UnimplementedError();
  }
}
