import 'package:go_router/go_router.dart';
import 'package:rick_and_morty_app/views/app_view.dart';

final router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder:
          (context, state, navigationShell) =>
              AppView(navigationShell: navigationShell),
      branches: const [],
    ),
  ],
);
