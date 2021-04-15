import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_get_chart_bloc.dart/coingecko_get_chart_event.dart';
import 'package:coinsnap/v2/bloc/coin_logic/aggregator/coingecko/coingecko_get_chart_bloc.dart/coingecko_get_chart_state.dart';
import 'package:coinsnap/v2/model/coin_model/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:coinsnap/v2/repo/coin_repo/aggregator/coingecko/add_coin_list_250/coingecko_list_250.dart';
import 'package:meta/meta.dart';
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

class CoingeckoGetChartBloc extends Bloc<CoingeckoGetChartEvent, CoingeckoGetChartState> {

  CoingeckoGetChartBloc({@required this.coingeckoList250Repository}) : super(CoingeckoGetChartInitialState());

  CoingeckoList250RepositoryImpl coingeckoList250Repository;

  @override
  Stream<CoingeckoGetChartState> mapEventToState(CoingeckoGetChartEvent event) async* {
    if (event is FetchCoingeckoGetChartEvent) {
      var listOfUserCoins = event.coinList;
      var timeSelection = event.timeSelection;
      yield CoingeckoGetChartLoadingState();

      try {
        /// ### data is a list of CoingeckoList250Model ### ///
        List<CoingeckoList250Model> data = await coingeckoList250Repository.getCoinMarketCapCoinLatest('1');

        Map<String, dynamic> coingeckoGetChartMap = {};

        data.forEach((coingeckoGetChartModel) => coingeckoGetChartMap[coingeckoGetChartModel.symbol] = coingeckoGetChartModel);

        yield CoingeckoGetChartLoadedState(coingeckoGetChartDataList: data, timeSelection: []);
        /// TODO: probably fix up LIST
      } catch (e) {
        log(e.toString());
        yield CoingeckoGetChartErrorState(errorMessage : e.toString());
      }
    }
  }
}
// }