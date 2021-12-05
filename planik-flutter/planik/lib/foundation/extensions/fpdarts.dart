import 'package:fpdart/fpdart.dart';

extension $TaskEither<L, R> on TaskEither<L, R> {
  TaskEither<L, R> startWith(Function() run) {
    run();
    return this;
  }

  TaskEither<D, C> flatMapAll<D, C>(
    TaskEither<D, C> Function(L l) left,
    TaskEither<D, C> Function(R r) right,
  ) {
    return TaskEither(
      () => run().then(
        (either) async => either.match(
          (l) => left(l).run(),
          (r) => right(r).run(),
        ),
      ),
    );
  }
}

tryCatchE<L, R>(
  Future<Either<L, R>> Function() run,
  L Function(Object error, StackTrace stackTrace) onError,
) {
  return TaskEither<L, R>(
    () async {
      try {
        return await run();
        // ignore: avoid_catches_without_on_clauses
      } catch (error, stack) {
        return Left<L, R>(onError(error, stack));
      }
    },
  );
}
