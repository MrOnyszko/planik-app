package pl.planik.app.hilt

import android.content.Context
import androidx.core.os.ConfigurationCompat
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import pl.planik.foundation.FoundationModule
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.util.*
import javax.inject.Singleton

@InstallIn(SingletonComponent::class)
@Module(
  includes = [
    FoundationModule::class
  ]
)
class AppModule {
  @Singleton
  @Provides
  @MediumDate
  fun provideMediumDateFormatter(
    @ApplicationContext context: Context
  ): DateTimeFormatter {
    return DateTimeFormatter.ofLocalizedDate(FormatStyle.MEDIUM).withLocale(context.locale())
  }

  @Singleton
  @Provides
  @MediumDateTime
  fun provideDateTimeFormatter(
    @ApplicationContext context: Context
  ): DateTimeFormatter {
    return DateTimeFormatter.ofLocalizedDateTime(FormatStyle.MEDIUM).withLocale(context.locale())
  }

  @Singleton
  @Provides
  @ShortDate
  fun provideShortDateFormatter(
    @ApplicationContext context: Context
  ): DateTimeFormatter {
    return DateTimeFormatter.ofLocalizedDate(FormatStyle.SHORT).withLocale(context.locale())
  }

  @Singleton
  @Provides
  @ShortTime
  fun provideShortTimeFormatter(
    @ApplicationContext context: Context
  ): DateTimeFormatter {
    return DateTimeFormatter.ofLocalizedTime(FormatStyle.SHORT).withLocale(context.locale())
  }

  @Singleton
  @Provides
  @FormatShortTime
  fun provideFormatShortTime(
    @ApplicationContext context: Context
  ): DateTimeFormatter {
    return DateTimeFormatter.ofPattern("EEEE").withLocale(context.locale())
  }

  @Singleton
  @Provides
  @DefaultCoroutineDispatcher
  fun providesDefaultCoroutineDispatcher(): CoroutineDispatcher = Dispatchers.Default
}

private fun Context.locale(): Locale {
  return ConfigurationCompat.getLocales(this.resources.configuration).get(0);
}