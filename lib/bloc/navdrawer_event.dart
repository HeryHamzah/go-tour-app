part of 'navdrawer_bloc.dart';

abstract class NavdrawerEvent extends Equatable {
  const NavdrawerEvent();
}

class ChangePage extends NavdrawerEvent {
  final int idPage;

  ChangePage(this.idPage);
  @override
  List<Object> get props => [idPage];
}
