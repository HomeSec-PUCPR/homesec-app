import 'package:homesec_app/src/shared/data/models/app_user_model.dart';

import '../../data/models/sensor_model.dart';

class HomeState {
  final AppUserModel user;
  final List<SensorModel> sensors;
  final bool loading;

  HomeState({
    required this.user,
    required this.sensors,
    this.loading = false,
  });

  factory HomeState.init() {
    return InitialHomeState();
  }

  HomeState setUser(AppUserModel user) {
    return UpdatedHomeState(user: user, sensors: sensors);
  }

  HomeState setSensors(List<SensorModel> sensors) {
    return UpdatedHomeState(user: user, sensors: sensors);
  }

  HomeState setLoading() {
    return LoadingHomeState(user: user, sensors: sensors);
  }
}

class InitialHomeState extends HomeState {
  InitialHomeState() : super(user: AppUserModel.empty(), sensors: []);
}

class LoadingHomeState extends HomeState {
  LoadingHomeState({
    required super.user,
    required super.sensors,
  }) : super(loading: true);
}

class UpdatedHomeState extends HomeState {
  UpdatedHomeState({
    required super.user,
    required super.sensors,
  });
}
