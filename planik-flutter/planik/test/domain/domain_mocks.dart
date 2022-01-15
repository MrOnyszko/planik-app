import 'package:mocktail/mocktail.dart';
import 'package:planik/domain/source/plan_local_source.dart';
import 'package:planik/domain/source/user_local_source.dart';

class MockUserLocalSource extends Mock implements UserLocalSource {}

class MockPlanLocalSource extends Mock implements PlanLocalSource {}