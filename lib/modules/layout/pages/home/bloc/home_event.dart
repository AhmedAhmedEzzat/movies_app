import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class HomeLoadEvent extends HomeEvent {
  final bool forceRefresh;
  const HomeLoadEvent({this.forceRefresh = false});

  @override
  List<Object?> get props => [forceRefresh];
}

class HomeRotateSectionsEvent extends HomeEvent {
  const HomeRotateSectionsEvent();
}

class HomeShuffleSectionsEvent extends HomeEvent {
  const HomeShuffleSectionsEvent();
}

class ChangeBackgroundEvent extends HomeEvent {
  final int index;
  const ChangeBackgroundEvent({required this.index});

  @override
  List<Object?> get props => [index];
}