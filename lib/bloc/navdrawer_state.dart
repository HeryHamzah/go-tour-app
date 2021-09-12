part of 'navdrawer_bloc.dart';

class NavdrawerState extends Equatable {
  final int idPage;

  NavdrawerState(this.idPage);

  @override
  List<Object> get props => [idPage];
}
