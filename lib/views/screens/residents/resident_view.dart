import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/location_model.dart';
import 'package:rick_and_morty_app/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty_app/views/widgets/character_card_list_view.dart';
import 'package:rick_and_morty_app/views/screens/residents/resident_view_model.dart';

class ResidentsView extends StatefulWidget {
  final LocationItem locationItem;
  const ResidentsView({super.key, required this.locationItem});

  @override
  State<ResidentsView> createState() => _ResidentsViewState();
}

class _ResidentsViewState extends State<ResidentsView> {
  @override
  void initState() {
    super.initState();
    context.read<ResidentViewModel>().getResidents(
      widget.locationItem.residents,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.locationItem.name),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Consumer<ResidentViewModel>(
              builder: (context, viewModel, child) {
                return CharacterCardListView(characters: viewModel.residents);
              },
            ),
          ],
        ),
      ),
    );
  }
}
