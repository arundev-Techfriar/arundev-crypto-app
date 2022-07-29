part of 'crypto_bloc.dart';

abstract class CryptoState extends Equatable {
  const CryptoState();
}

///Loading state
class CryptoLoadingState extends CryptoState {
  @override
  List<Object> get props => [];
}

///Loaded state, passing data in list which is fetched from api to pages
class CryptoLoadedState extends CryptoState {
  final List<Result> crypto;

  CryptoLoadedState(this.crypto);

  @override
  List<Object?> get props => [crypto];
}
