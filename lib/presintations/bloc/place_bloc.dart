import 'package:bloc/bloc.dart';
import 'package:favourite_places/data/models/place.dart';
import 'package:favourite_places/data/places_remote_data_source.dart';
import 'package:favourite_places/presintations/pages/add_place_page.dart';
import 'package:meta/meta.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceRemoteDs remoteDs;
  PlaceBloc(this.remoteDs) : super(PlaceInitial()) {
    on<PlaceEvent>((event, emit) async {
      try {
        if (event is AddPlace) {
          emit(PlaceLoadingState());
          await remoteDs.addPlace(event.place);
          add(GetPlace());
        } else if (event is GetPlace) {
          emit(PlaceLoadingState());
          final places = await remoteDs.getPlace();
          emit(PlaceLoaded(places: places));
        } else if (event is RemovePlace) {
          emit(PlaceLoadingState());
          await remoteDs.removePlace(event.id);
          add(GetPlace());
        } else if (event is UpdatePlace) {
          emit(PlaceLoadingState());
          await remoteDs.updatePlace(event.place);
          add(GetPlace());
        }
      } catch (e) {
        emit(PlaceErrorState(errorMessage: e.toString()));
      }
    });
  }
}
