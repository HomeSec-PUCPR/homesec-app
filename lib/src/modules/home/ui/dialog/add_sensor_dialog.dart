import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:homesec_app/src/shared/ui/components/text_field.dart';
import 'package:validators/validators.dart';

import '../../interactor/stores/home_store.dart';

class AddSensorDialog extends StatelessWidget {
  const AddSensorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Modular.get<HomeStore>();

    final nameController = TextEditingController();
    final serialController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextFormField(
              controller: nameController,
              label: "Nome",
            ),
            const SizedBox(height: 16),
            AppTextFormField(
              controller: serialController,
              label: "Serial",
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (isNull(nameController.text) ||
                    isNull(serialController.text)) return;
                store.createSensor(
                    name: nameController.text, serial: serialController.text);
                Modular.to.pop();
              },
              child: const Text("Adicionar"),
            ),
          ],
        ),
      ),
    );
  }
}
