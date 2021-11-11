package pl.planik.local

import android.content.Context
import android.os.Debug
import androidx.room.Room
import dagger.Binds
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import pl.planik.domain.source.UserLocalSource
import pl.planik.local.source.UserLocalSourceImpl
import javax.inject.Singleton

@InstallIn(SingletonComponent::class)
@Module(
  includes = [
    LocalSourceModule::class
  ]
)
class LocalModule {

  @Singleton
  @Provides
  fun provideDatabase(
    @ApplicationContext context: Context
  ): LocalDatabase {
    return Room.databaseBuilder(context, LocalDatabase::class.java, "planik.db")
      .fallbackToDestructiveMigration()
      .apply {
        if (Debug.isDebuggerConnected()) {
          allowMainThreadQueries()
        }
      }.build()
  }

  @Provides
  fun providesUsersDao(db: LocalDatabase) = db.usersDao()

}

@InstallIn(SingletonComponent::class)
@Module
abstract class LocalSourceModule {
  @Binds
  abstract fun bindsUserLocalSource(
    userLocalSourceImpl: UserLocalSourceImpl
  ): UserLocalSource
}