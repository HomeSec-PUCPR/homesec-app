import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:homesec_app/src/modules/home/ui/dialog/add_sensor_dialog.dart';
import 'package:homesec_app/src/shared/interactor/services/auth_service.dart';
import 'package:homesec_app/src/shared/utils.dart';

import '../../data/models/sensor_model.dart';
import '../../interactor/state/home_state.dart';
import '../../interactor/stores/home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = Modular.get<HomeStore>();
  final auth = Modular.get<AuthService>();

  @override
  void initState() {
    super.initState();
    store.init();
  }

  AppBar _buildHeader() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Image.asset(AppIcons.logo, width: 80),
    );
  }

  Widget _buildStatus() {
    return ScopedBuilder<HomeStore, HomeState>(
      store: store,
      onState: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(40),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                (state.sensors.isEmpty)
                    ? AppIcons.personQuestion
                    : (state.sensors.any((s) => s.status))
                        ? AppIcons.warning
                        : AppIcons.wifiSignal,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildStatus(),
        Expanded(child: _buildSensors()),
      ],
    );
  }

  Widget _buildSensors() {
    Widget empty() {
      return Expanded(
        child: Center(
          child: ScopedBuilder<HomeStore, HomeState>(
            store: store,
            onState: (context, state) {
              return Text(
                "${state.user.name}, parece que ainda não há nenhum sensor registrado!",
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      );
    }

    Widget list(List<SensorModel> sensors) {
      return Expanded(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 16),
          itemBuilder: (context, index) {
            final sensor = sensors[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(8),
                color: sensor.status ? AppColors.danger : Colors.white,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                  child: Text(
                sensor.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: sensor.status ? Colors.white : Colors.black,
                ),
              )),
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemCount: sensors.length,
        ),
      );
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 12,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SENSORES",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ScopedBuilder<HomeStore, HomeState>(
            store: store,
            onState: (context, state) {
              if (state.sensors.isEmpty) {
                return empty();
              }
              return list(state.sensors);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddSensor() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.15),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16)
          .copyWith(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
      child: ElevatedButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) {
              return const AddSensorDialog();
            },
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Theme.of(context).primaryColor,
          ),
          overlayColor: MaterialStateProperty.all(
            Colors.white.withOpacity(0.15),
          ),
        ),
        child: Text(
          "Adicionar sensor",
          style: TextStyle(color: AppColors.white),
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                await auth.signOut();
                Modular.to.navigate(Routes.loginPage());
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<HomeStore, HomeState>(
      store: store,
      onState: (context, state) {
        return Scaffold(
          backgroundColor: state.sensors.any((s) => s.status)
              ? AppColors.danger
              : Theme.of(context).primaryColor,
          bottomNavigationBar: _buildAddSensor(),
          appBar: _buildHeader(),
          body: _buildBody(),
          drawer: _buildDrawer(),
        );
      },
    );
  }
}
