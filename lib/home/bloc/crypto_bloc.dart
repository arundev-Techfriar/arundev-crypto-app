import 'package:bloc/bloc.dart';
import 'package:crypto_news_app/home/model/crypto_news_model.dart';
import 'package:crypto_news_app/home/resources/crypto_network_service.dart';
import 'package:equatable/equatable.dart';

part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  ///creating object of the class to access the method which is fetching the data from the API
  final CryptoNewsService _reminderService;
  CryptoBloc(this._reminderService) : super(CryptoLoadingState()) {
    on<LoadCryptoApiEvent>((event, emit) async {
      final activity = await _reminderService.getCryptoNews();

      ///emit the data fetched from api into the CryptoLoadedState
      emit(CryptoLoadedState(activity.results));
    });
  }
}
