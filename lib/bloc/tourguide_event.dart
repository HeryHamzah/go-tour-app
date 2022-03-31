part of 'tourguide_bloc.dart';

abstract class TourGuideEvent extends Equatable {
  const TourGuideEvent();
}

class LoadTourGuide extends TourGuideEvent {
  final String id;

  LoadTourGuide(this.id);

  @override
  List<Object> get props => [id];
}

class SignOutTourGuide extends TourGuideEvent {
  @override
  List<Object> get props => [];
}

class ChangeStatusTourGuide extends TourGuideEvent {
  final String tourGuideID;
  final bool status;

  ChangeStatusTourGuide(this.tourGuideID, this.status);
  @override
  List<Object> get props => [];
}
