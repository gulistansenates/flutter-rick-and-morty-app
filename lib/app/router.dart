import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/models/characters_model.dart';
import 'package:rick_and_morty_app/models/episode_model.dart';
import 'package:rick_and_morty_app/models/location_model.dart';
import 'package:rick_and_morty_app/views/app_view.dart';
import 'package:rick_and_morty_app/views/screens/character profile/character_profile_view.dart';
import 'package:rick_and_morty_app/views/screens/character profile/character_profile_view_model.dart';
import 'package:rick_and_morty_app/views/screens/characters/characters_view.dart';
import 'package:rick_and_morty_app/views/screens/characters/characters_view_model.dart';
import 'package:rick_and_morty_app/views/screens/favorites/favorites_view.dart';
import 'package:rick_and_morty_app/views/screens/favorites/favorites_view_model.dart';
import 'package:rick_and_morty_app/views/screens/locations/location_view_model.dart';
import 'package:rick_and_morty_app/views/screens/locations/locations_view.dart';
import 'package:rick_and_morty_app/views/screens/residents/resident_view.dart';
import 'package:rick_and_morty_app/views/screens/residents/resident_view_model.dart';
import 'package:rick_and_morty_app/views/screens/section characters/section_characters_view.dart';
import 'package:rick_and_morty_app/views/screens/section characters/section_characters_view_model.dart';
import 'package:rick_and_morty_app/views/screens/sections/sections_view.dart';
import 'package:rick_and_morty_app/views/screens/sections/sections_view_model.dart';
import 'package:rick_and_morty_app/views/screens/settings/settings_view_model.dart';
import '../views/screens/settings/settings_view.dart';

final _routerKey = GlobalKey<NavigatorState>();
final _shellNavigatorCharactersKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellCharacters',
);
final _shellNavigatorFavoritesKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellFavorites',
);
final _shellNavigatorLocationsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellLocations',
);
final _shellNavigatorSectionsKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellSections',
);

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favorites = '/favorites';
  static const String locations = '/locations';
  static const String sections = '/sections';
  static const String settings = '/settings';

  static const String profileRoute = 'characterProfile';
  static const String characterProfile = '/characterProfile';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';

  static const String sectionCharactersRoute = 'characters';
  static const String sectionCharacters = '/sections/characters';
}

final router = GoRouter(
  navigatorKey: _routerKey,
  initialLocation: AppRoutes.characters,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppView(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCharactersKey,
          routes: [
            GoRoute(
              path: AppRoutes.characters,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => CharactersViewModel(),
                    child: const CharactersView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.profileRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => CharacterProfileViewModel(),
                        child: CharacterProfileView(
                          characterModel: state.extra as CharacterModel,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorFavoritesKey,
          routes: [
            GoRoute(
              path: AppRoutes.favorites,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => FavoritesViewModel(),
                    child: const FavoritesView(),
                  ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorLocationsKey,
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => LocationViewModel(),
                    child: const LocationsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => ResidentViewModel(),
                        child: ResidentsView(
                          locationItem: state.extra as LocationItem,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSectionsKey,
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder:
                  (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionsViewModel(),
                    child: const SectionsView(),
                  ),
              routes: [
                GoRoute(
                  path: AppRoutes.sectionCharactersRoute,
                  builder:
                      (context, state) => ChangeNotifierProvider(
                        create: (context) => SectionCharactersViewModel(),
                        child: SectionCharactersView(
                          episodeModel: state.extra as EpisodeModel,
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder:
          (context, state) => ChangeNotifierProvider(
            create: (context) => SettingsViewModel(),
            child: const SettingsView(),
          ),
    ),
  ],
);
