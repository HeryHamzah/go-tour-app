part of 'tourguide_bloc.dart';

abstract class TourguideState extends Equatable {
  const TourguideState();
  
  @override
  List<Object> get props => [];
}

class TourguideInitial extends TourguideState {}
