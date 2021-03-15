import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_bloc/get_coin_list_bloc.dart';
import 'package:coinsnap/v2/bloc/app_logic/get_coin_list_total_value_bloc/get_coin_list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/latest/card_coinmarketcap_coin_latest_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/quotes/list_total_value_bloc/list_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/card/top100/top100_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coinmarketcap/global/global_coinmarketcap_stats_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_price_info_bloc/get_price_info_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/get_total_value_bloc/get_total_value_bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/exchange/get_requests/binance_get_chart_bloc/binance_get_chart_bloc.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_latest.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/card/card_coinmarketcap_coin_list.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coinmarketcap/global/global_coinmarketcap_stats_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_all_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_chart_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_exchange_info_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_get_prices_repo.dart';
import 'package:coinsnap/v2/repo/coin_repo/exchange/binance/binance_sell_coin_repo.dart';
import 'package:coinsnap/v2/ui/authentication/authentication.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_add.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_edit.dart';
import 'package:coinsnap/v2/ui/core_widgets/coins/coin_page/coin_page.dart';
import 'package:coinsnap/v2/ui/main/dashboard.dart';
import 'package:coinsnap/v2/ui/main/home_view.dart';
import 'package:coinsnap/v2/ui/welcome/first.dart';
import 'package:coinsnap/v2/ui/welcome/second.dart';
import 'package:coinsnap/v2/bloc/coin_logic/controller/sell_portfolio_bloc/sell_portfolio_bloc.dart';
import 'package:coinsnap/working_files/dashboard_initial_noAPI.dart';
import 'package:coinsnap/working_files/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetTotalValueBloc>(
          create: (BuildContext context) => GetTotalValueBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<GetPriceInfoBloc>(
          create: (context) => GetPriceInfoBloc(binanceGetPricesRepository: BinanceGetPricesRepositoryImpl()),
        ),
        BlocProvider<SellPortfolioBloc>(
          create: (context) => SellPortfolioBloc(binanceSellCoinRepository: BinanceSellCoinRepositoryImpl(), binanceGetAllRepository: BinanceGetAllRepositoryImpl(), binanceExchangeInfoRepository: BinanceExchangeInfoRepositoryImpl()),
        ),
        BlocProvider<CardCoinmarketcapCoinLatestBloc> (
          create: (context) => CardCoinmarketcapCoinLatestBloc(cardCoinmarketcapCoinLatestRepository: CardCoinmarketcapCoinLatestRepositoryImpl()),
        ),
        BlocProvider<GlobalCoinmarketcapStatsBloc> (
          create: (context) => GlobalCoinmarketcapStatsBloc(globalCoinmarketcapStatsRepository: GlobalCoinmarketcapStatsRepositoryImpl()),
        ),
        BlocProvider<BinanceGetChartBloc> (
          create: (context) => BinanceGetChartBloc(binanceGetChartRepository: BinanceGetChartRepositoryImpl()),
        ),
        BlocProvider<ListTotalValueBloc> (
          create: (context) => ListTotalValueBloc(listTotalValueRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        ),
        BlocProvider<Top100TotalValueBloc> (
          create: (context) => Top100TotalValueBloc(cardCoinmarketcapCoinLatestRepository: CardCoinmarketcapCoinLatestRepositoryImpl()),
        ),
        BlocProvider<GetCoinListBloc> (
          create: (context) => GetCoinListBloc(binanceGetAllRepository: BinanceGetAllRepositoryImpl()),
        ),
        BlocProvider<GetCoinListTotalValueBloc> (
          create: (context) => GetCoinListTotalValueBloc(coinmarketcapListQuoteRepository: CardCoinmarketcapCoinListRepositoryImpl()),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/dashboard',
        routes: {
          '/errorscreen': (context) => ErrorScreen(),
          '/dashboard': (context) => Dashboard(),
          '/coinpage': (context) => CoinPage(),
          '/first': (context) => First(),
          '/second': (context) => Second(),
          '/authentication': (context) => Authentication(),
          '/hometest': (context) => HomeView(),
          '/editcointest': (context) => EditCoin(),
          '/addcointest': (context) => AddCoin(),
          '/dashboardnoapitest': (context) => DashboardNoApiView(),
          '/dashboardwithcategory': (context) => DashboardWithCategory(),
        }
      ),
    );
  }
}
