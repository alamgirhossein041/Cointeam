import 'package:coinsnap/modules/portfolio/pages/portfolio_dashboard.dart';
/// user flow 1: preloaded list of coins from coingecko
/// 1. User opens app
/// 2. User clicks on portfolio
/// 3. User presses + (add coin)
/// User does this in rapid succession or has a bot doing it
/// mock coingecko response taking a long time or failed to retrieve
/// user starts typing a coin to add
/// > portfolio button doesn't appear until Coinmarketcap data returns
/// 
/// Expect add to portfolio button is greyed out
/// note: this doesn't solve the problem of coingecko failing
/// note: may locally cache list of coins
/// 
/// if user searches for coin which doesn't exist on coinlist,
/// the app doesn't show any search results
/// should let the user do it anyway, and make a network call?
/// 
/// user flow 2: User searches for coin, then list loads after
/// 1. Coingecko's list has not yet loaded
/// 2. User starts typing to search for a coin
/// 3. During or after the user has typed, the coinlist finishes loading
/// 4. when list finishes loading, maybe fire a search against the list with the input?
/// 
/// user flow 3: presses + (add coin), no input for quantity
/// 1. User searches for coin. selects one from list
/// 2. Doesn't enter a quantity (set to 0 by default)
/// 3. Presses add to portfolio
/// 4. Coin should be added to portfolio with default 0 value
/// 


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// import 'test_helper.dart';

void main() {

  

  final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();

  // testWidgets("Basic layout test (mobile device)", (tester) async {
    // binding.window.physicalSizeTestValue = Size(400, 200);
    // binding.window.devicePixelRatioTestValue = 1.0;

    // await tester.pumpWidget(new MyApp());

    // expect(find.byType(MyHomePage), findsOneWidget);
    // etc.
  testWidgets('Press Add Coin Button NSUFOSDIJF', (WidgetTester tester) async {
    binding.window.physicalSizeTestValue = Size(800, 400);
    binding.window.devicePixelRatioTestValue = 1.0;
    
    // var mediaQuery = buildTestableWidget(Dashboard());
    await tester.pumpWidget(Dashboard());
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
    var menuButton = find.byIcon(Icons.menu);
    await tester.tap(menuButton);
    await tester.pump();
    expect(find.text('Test Binance'), findsOneWidget);
    await tester.tapAt(Offset.fromDirection(0, 395));
    var button = find.byIcon(Icons.add);
    await tester.tap(button);
    await tester.pump();
    expect(find.text('Add Coin'), findsOneWidget);
  }
  );
}