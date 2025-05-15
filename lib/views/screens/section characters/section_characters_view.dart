import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/episode_model.dart';
import 'package:rick_and_morty_app/views/screens/section characters/section_characters_view_model.dart';
import 'package:rick_and_morty_app/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty_app/views/widgets/character_card_list_view.dart';

class SectionCharactersView extends StatefulWidget {
  final EpisodeModel episodeModel;
  const SectionCharactersView({super.key, required this.episodeModel});

  @override
  State<SectionCharactersView> createState() => _SectionCharactersViewState();
}

class _SectionCharactersViewState extends State<SectionCharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionCharactersViewModel>().getCharacters(
      widget.episodeModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: widget.episodeModel.episode),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Consumer<SectionCharactersViewModel>(
              builder: (context, viewModel, child) {
                return CharacterCardListView(characters: viewModel.characters);
              },
            ),
          ],
        ),
      ),
    );
  }
}
