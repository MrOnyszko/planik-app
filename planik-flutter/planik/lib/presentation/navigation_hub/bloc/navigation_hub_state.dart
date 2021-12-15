part of 'navigation_hub_bloc.dart';

@freezed
class NavigationHubState with _$NavigationHubState {
  const factory NavigationHubState({
    required bool hasUser,
    required bool hasPlan,
  }) = _NavigationHubState;

  factory NavigationHubState.initial() {
    return const NavigationHubState(
      hasUser: false,
      hasPlan: false,
    );
  }
}

extension NavigationHubStates on NavigationHubState {
  bool get openPlanScreen => hasUser && hasPlan;
  bool get openCreatePlanIncentiveScreen => hasUser && !hasPlan;
  bool get openUserNameScreen => !hasUser;
}
