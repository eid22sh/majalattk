import 'package:bloc/bloc.dart';
import 'package:majalatek/models/providers/providers_model.dart';
import 'package:majalatek/services/providers_service.dart';
import 'package:majalatek/utils/widget_convertor.dart';
import 'package:majalatek/view/screens/HomeScreen/widgets/provider_marker.dart';

class ProviderBloc extends Cubit<List<ProviderModel>> {
  ProviderBloc._() : super([]);
  static final instance = ProviderBloc._();
  Future<int> getProviders() async {
    var providers = await ProvidersService.instance.getNearbyProviders();
    List<ProviderModel> finalList = [];
    for (ProviderModel provider in providers) {
      if (provider.isSpecial.compareTo("0") == 0) {
      } else {
        await provider.getImage();
        var icon =
            await WidgetConverter.instance.createImageFromWidget(ProviderMarker(
          imageprovider: provider.imageProvider,
        ));
        provider.icon = icon;
        finalList.add(provider);
      }
    }
    ProvidersService.instance.getNearbySpecialities();
    emit(finalList);
    return finalList.length;
  }
}
