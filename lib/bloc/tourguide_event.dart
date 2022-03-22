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
