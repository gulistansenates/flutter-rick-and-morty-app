import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty_app/views/widgets/character_card_list_view.dart';

import 'favorites_view_model.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesViewModel>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoritesViewModel>();
    return Scaffold(
      appBar: const AppBarWidget(title: 'Favorilerim'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child:
              viewModel.characters.isEmpty
                  ? const CircularProgressIndicator.adaptive()
                  : Column(
                    children: [
                      CharacterCardListView(characters: viewModel.characters),
                    ],
                  ),
        ),
      ),
    );
  }
}
