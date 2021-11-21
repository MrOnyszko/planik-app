package pl.planik.foundation

import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent

@InstallIn(SingletonComponent::class)
@Module
abstract class FoundationModule {
  @Binds
  abstract fun bindDateProvider(
    dateProviderImpl: DateProviderImpl
  ): DateProvider
}
