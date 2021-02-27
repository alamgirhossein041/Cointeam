import 'package:bloc/bloc.dart';
import 'package:coinsnap/v1/bloc/ui/portfolio_builder_bloc/portfolio_builder_event.dart';
import 'package:coinsnap/v1/bloc/ui/portfolio_builder_bloc/portfolio_builder_state.dart';
import 'package:coinsnap/v1/data/repository/ui/portfolio_builder_repository.dart';
import 'package:meta/meta.dart';

class PortfolioBuilderBloc extends Bloc<PortfolioBuilderEvent, PortfolioBuilderState> {

  PortfolioBuilderRepositoryImpl repository;

  PortfolioBuilderBloc({@required this.repository}) : super(PortfolioBuilderInitialState());
  
  // PortfolioBuilderBloc({@required this.repository}) : super(PortfolioBuilderInitialState());
  /// initialState has been changed to the above: https://github.com/felangel/bloc/issues/1304

  // PortfolioBuilderRepositoryImpl repository;

  @override
  Stream<PortfolioBuilderState> mapEventToState(PortfolioBuilderEvent event) async* {
    if (event is FetchPortfolioBuilderEvent) {
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
}