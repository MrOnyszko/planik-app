import 'package:flutter/foundation.dart';

@immutable
class PlanArgument {
  const PlanArgument({
    this.id,
  });

  final int? id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanArgument && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'PlanArgument{id: $id}';
  }
}
