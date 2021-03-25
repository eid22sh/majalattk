import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/providers_service.dart';

class FlagBloc extends Cubit {
  FlagBloc(state) : super([]);
  static final instance = FlagBloc([]);

  getCountries() async {
    emit([]);
    var countries = await ProvidersService.instance.getCountries();
    emit(countries["data"]);
  }
}
