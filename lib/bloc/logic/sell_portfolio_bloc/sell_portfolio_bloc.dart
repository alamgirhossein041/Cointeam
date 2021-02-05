import 'package:coinsnap/data/respository/auth/sell_coin.dart/binance_sell_coin.dart';

class SellPortfolioBloc extends Bloc<SellPortfolioEvent, SellPortfolioState> {
  
  SellPortfolioBloc({this.binanceSellCoinRepository}) : super(SellPortfolioInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  BinanceSellCoinRepositoryImpl binanceSellCoinRepository;
  /// CoinbaseSellCoinRepositoryImpl coinbaseSellCoinRepository;
  /// FtxSellCoinRepositoryImpl ftxSellCoinRepository;

  // BinanceGetPricesRepositoryImpl binanceGetPricesRepository;

  @override
  Stream<SellPortfolioState> mapEventToState(SellPortfolioEvent event) async* {

  }
}