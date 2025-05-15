import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty_app/views/widgets/decorated_container.dart';
import 'package:rick_and_morty_app/views/widgets/episodes_list_view.dart';
import 'sections_view_model.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionsViewModel>().getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppBarWidget(
          title: 'Bölümler',
          transparentBackground: true,
        ),
        body: DecoratedContainer(
          topChild: const SizedBox(height: 74),
          child: Consumer<SectionsViewModel>(
            builder: (context, viewModel, child) {
              if (viewModel.episodesModel == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: EpisodesListView(
                    episodes: viewModel.episodesModel!.episodes,
                    onLoadMore: viewModel.onLoadMore,
                    loadMore: viewModel.loadMore,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
