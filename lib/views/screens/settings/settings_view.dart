import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/app/theme.dart';
import 'package:rick_and_morty_app/views/widgets/appbar_widget.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'Ayarlar', hideSettings: true),
      body: Center(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Karanlık Tema'),
              trailing: Switch(
                value: context.watch<AppTheme>().themeMode == ThemeMode.dark,
                onChanged: (v) => context.read<AppTheme>().toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
