import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:majalatek/services/providers_service.dart';

class SearchBloc extends Cubit<Map<String, List<Map>>> {
  SearchBloc(List<String> initialState)
      : super({"data": ProvidersService.instance.nearbySpecialities});

  static final instance = SearchBloc([]);

  searchNearbySpecialities(String searchKey) {
    if (searchKey.length == 0) {
      setNearbySpecialities();
    } else {
      ProvidersService.instance.searchNearbySpecialities(searchKey);

      emit({"data": ProvidersService.instance.searchResultSpecialities});
    }
  }

  setNearbySpecialities() {
    emit({"data": ProvidersService.instance.nearbySpecialities});
  }
}
