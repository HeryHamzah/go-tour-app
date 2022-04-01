import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_tourguide_app/models/models.dart';
import 'package:travel_tourguide_app/services/services.dart';

part 'tourguide_event.dart';
part 'tourguide_state.dart';

class TourGuideBloc extends Bloc<TourGuideEvent, TourGuideState> {
  TourGuideBloc() : super(TourGuideInitial());

  @override
  Stream<TourGuideState> mapEventToState(
    TourGuideEvent event,
  ) async* {
    if (event is LoadTourGuide) {
      TourGuide tourGuide = await TourGuideServices.getTourGuide(event.id);

      yield TourGuideLoaded(tourGuide);
    } else if (event is SignOutTourGuide) {
      yield TourGuideInitial();
    } else if (event is ChangeStatusTourGuide) {
      await TourGuideServices.changeStatus(event.tourGuideID, event.status);

      TourGuide tourGuide =
          (state as TourGuideLoaded).tourGuide.copyWith(status: event.status);

      yield TourGuideLoaded(tourGuide);
    } else if (event is UpdateTourGuide) {
      await TourGuideServices.updateTourGuide(event.tourGuide);
      if (event.imageFile != null) {
        await TourGuideServices.uploadTourGuideImage(
            imageFile: event.imageFile,
            tourGuideID: event.tourGuide.tourGuideID);
      }

      yield TourGuideLoaded(event.tourGuide);
    }
  }
}
