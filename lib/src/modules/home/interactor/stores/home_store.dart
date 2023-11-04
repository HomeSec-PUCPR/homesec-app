import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:homesec_app/src/modules/home/data/models/sensor_model.dart';
import 'package:homesec_app/src/shared/interactor/services/auth_service.dart';

import '../state/home_state.dart';

class HomeStore extends Store<HomeState> implements Disposable {
  final AuthService _authService;
  HomeStore(this._authService) : super(HomeState.init());

  final _firebaseDb = FirebaseFirestore.instance;

  StreamSubscription? _stream;

  @override
  void dispose() {
    _stream?.cancel();
  }

  void init() {
    update(state.setUser(_authService.user));
    getSensors();
  }

  void getSensors() {
    final ref = _firebaseDb
        .collection("Users")
        .doc(_authService.firebaseUser!.uid)
        .collection("Sensors");

    _stream = ref.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        List<SensorModel> sensors =
            event.docs.map((e) => SensorModel.fromJson(e.data())).toList();
        update(state.setSensors(sensors));
      }
    });
  }

  void createSensor({required String name, required String serial}) {
    final body = {
      "Name": name,
      "Serial": serial,
      "Status": false,
      "CreatedAt": Timestamp.now(),
    };
    final ref = _firebaseDb
        .collection("Users")
        .doc(_authService.firebaseUser!.uid)
        .collection("Sensors");
    ref.add(body);
  }
}
