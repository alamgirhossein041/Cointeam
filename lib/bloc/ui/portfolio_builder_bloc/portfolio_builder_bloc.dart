import 'package:bloc/bloc.dart';
import 'package:coinsnap/bloc/ui/portfolio_builder_bloc/portfolio_builder_event.dart';
import 'package:coinsnap/bloc/ui/portfolio_builder_bloc/portfolio_builder_state.dart';
import 'package:coinsnap/bloc/unauth/exchange/binance_exchange_info_bloc/binance_exchange_info_event.dart';
import 'package:coinsnap/bloc/unauth/exchange/binance_exchange_info_bloc/binance_exchange_info_state.dart';
import 'package:coinsnap/data/model/unauth/exchange/binance_exchange_info_model.dart';
import 'package:coinsnap/data/repository/unauth/exchange/binance_get_exchange_info.dart';
import 'package:meta/meta.dart';

// class PortfolioBuilderBloc extends Bloc<PortfolioBuilderEvent, PortfolioBuilderState> {
  
  // PortfolioBuilderBloc({@required this.repository}) : super(PortfolioBuilderInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // PortfolioBuilderRepositoryImpl repository;

  @override
  Stream<PortfolioBuilderState> mapEventToState(PortfolioBuilderEvent event) async* {
    if (event is FetchBinanceExchangeInfoEvent) {
      yield PortfolioBuilderLoadingState();

      try {
        // List<PortfolioBuilderModel> PortfolioBuilderModel = []; /// await repository.getData
        /// TODO: probably fix up LIST
        // yield PortfolioBuilderLoadedState(PortfolioBuilderModel: portfolioBuilderModel);
      } catch (e) {
        yield PortfolioBuilderErrorState(errorMessage : e.toString());
      }
    }
  }
// }