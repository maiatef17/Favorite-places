part of 'place_bloc.dart';

@immutable
sealed class PlaceEvent {}

class GetPlace extends PlaceEvent {}

class AddPlace extends PlaceEvent {
  final Place place;

  AddPlace({required this.place});
}

class RemovePlace extends PlaceEvent {
  final String id;

  RemovePlace({required this.id});
}

class UpdatePlace extends PlaceEvent {
  final Place place;

  UpdatePlace({required this.place});
}
