import 'package:flutter/foundation.dart';

@immutable
class CreatePlanArgument {
  const CreatePlanArgument({
    this.id,
  });

  final int? id;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CreatePlanArgument && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'CreatePlanArgument{id: $id}';
  }
}
