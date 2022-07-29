part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();
}

///Load api event
class LoadCryptoApiEvent extends CryptoEvent {
  @override
  List<Object?> get props => [];
}
