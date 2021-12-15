part of 'navigation_hub_bloc.dart';

@freezed
class NavigationHubEvent with _$NavigationHubEvent {
  const factory NavigationHubEvent.started() = _NavigationHubStarted;
}
