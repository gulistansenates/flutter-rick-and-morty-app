import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/views/screens/locations/location_list_view.dart';
import 'package:rick_and_morty_app/views/screens/locations/location_view_model.dart';
import 'package:rick_and_morty_app/views/widgets/appbar_widget.dart';
import 'package:rick_and_morty_app/views/widgets/decorated_container.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  @override
  void initState() {
    super.initState();
    context.read<LocationViewModel>().getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppBarWidget(
          title: 'Konumlar',
          transparentBackground: true,
        ),
        body: DecoratedContainer(
          topChild: const SizedBox(height: 74),
          child: _locationListView(),
        ),
      ),
    );
  }

  Widget _locationListView() {
    return Consumer<LocationViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.locationModel == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: LocationListView(
              locationModel: viewModel.locationModel!,
              onLoadMore: viewModel.getMoreLocation,
              loadMore: viewModel.loadMore,
            ),
          );
        }
      },
    );
  }
}
