fvm flutter test --reporter expanded --coverage
lcov --remove coverage/lcov.info -o coverage/clean_lcov.info \
  '**/**.g.dart' \
  '**/**.route.dart' \
  'lib/presentation/common/*' \
  'lib/presentation/l10n/*' \
  'lib/presentation/router/*' \
  'lib/presentation/injector_container.dart' \
  'lib/domain/domain_injector.dart' \
  'lib/local/local_injector.dart' \
  'lib/local/database_provider.dart' \
  'lib/local/**.g.dart' \
  'lib/foundation/extensions/**'

genhtml coverage/clean_lcov.info -o coverage/app/