package pl.planik.foundation

import java.time.Instant
import java.time.OffsetDateTime
import java.time.ZoneId
import javax.inject.Inject
import javax.inject.Singleton

interface DateProvider {
  fun offsetDateTimeNow(): OffsetDateTime
  fun offsetDateTimeNow(zone: ZoneId): OffsetDateTime
  fun instantNow(): Instant
}

@Singleton
class DateProviderImpl @Inject constructor() : DateProvider {
  override fun offsetDateTimeNow(): OffsetDateTime = OffsetDateTime.now()
  override fun offsetDateTimeNow(zone: ZoneId): OffsetDateTime = OffsetDateTime.now(zone)
  override fun instantNow(): Instant = Instant.now()
}