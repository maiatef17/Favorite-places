part of 'place_bloc.dart';

@immutable
sealed class PlaceState {}

final class PlaceInitial extends PlaceState {}

final class PlaceLoadingState extends PlaceState {}

final class PlaceLoaded extends PlaceState {
  final List <Place> places;

  PlaceLoaded({required this.places});
}

final class PlaceErrorState extends PlaceState {
  final String errorMessage;

  PlaceErrorState({required this.errorMessage});
}
