import 'dart:developer';
import 'dart:isolate';

void startupIsolate(SendPort sendPort) async {

  /// Port for receiving messages
  var port = ReceivePort();

  /// Isolate's way of sending messages/parameters to other Isolates
  sendPort.send(port.sendPort);

  await for (var comparisons in port) {
    if(comparisons[0] == comparisons[1]) {
      log("Sending port true");
      sendPort.send(true);
    } else { 
      log("Sending port false");
      sendPort.send(false);
    }
  }




  /// Listen for messages (optional)
  // await for (var data in port) {}
}