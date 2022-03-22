part of 'tourguide_bloc.dart';

abstract class TourGuideState extends Equatable {
  const TourGuideState();
}

class TourGuideInitial extends TourGuideState {
  @override
  List<Object> get props => [];
}

class TourGuideLoaded extends TourGuideState {
  final TourGuide tourGuide;

  TourGuideLoaded(this.tourGuide);

  @override
  List<Object> get props => [tourGuide];
}
