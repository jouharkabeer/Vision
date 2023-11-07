import 'package:firebase_database/firebase_database.dart';
import 'package:stacked/stacked.dart';

import '../app/app.logger.dart';
import '../models/models.dart';

class DbService with ListenableServiceMixin {
  final log = getLogger('RealTimeDB_Service');

  FirebaseDatabase _db = FirebaseDatabase.instance;

  Node? _node;
  Node? get node => _node;

  int? _alertValue;
  int? get alertValue => _alertValue;

  void setupNodeListening() {
    DatabaseReference starCountRef = _db.ref('/realtime_data/node');
    starCountRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        _node = Node.fromMap(event.snapshot.value as Map);
        // log.v(_node?.lastSeen); //data['time']
        notifyListeners();
      }
    });
  }

  void setupAlertListening() {
    DatabaseReference starCountRef = _db.ref('/alert');
    starCountRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.exists) {
        _alertValue = event.snapshot.value as int;
        // log.v(_node?.lastSeen); //data['time']
        notifyListeners();
      }
    });
  }

  ///Chat status stream
  // Stream<ChatStatus> chatStatusStream(String receiverUid, String chatId) {
  //   try {
  //     DatabaseReference chatStatusRef =
  //         _db.reference().child('/chat/$chatId/$receiverUid');
  //     handleData(Event event, EventSink<ChatStatus> sink) =>
  //         sink.add(ChatStatus.fromMap(event.snapshot.value));
  //     final transformer = StreamTransformer<Event, ChatStatus>.fromHandlers(
  //         handleData: handleData);
  //     return chatStatusRef.onValue.transform(transformer);
  //   } catch (e) {
  //     print(e);
  //     return Stream<ChatStatus>.value(null);
  //   }
  // }
}
