package pl.planik.local

import android.content.Context
import android.content.SharedPreferences
import dagger.hilt.android.qualifiers.ApplicationContext
import java.util.UUID
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UserPreferences @Inject constructor(
  @ApplicationContext context: Context
) {

  companion object {
    const val PREF_USER_ID = "user_id"
    const val PREF_USER_UUID = "user_uuid"
  }

  private var sharedPreferences: SharedPreferences =
    context.getSharedPreferences("${context.packageName}.preferences", Context.MODE_PRIVATE)

  var uuid: String?
    get() = sharedPreferences.getString(PREF_USER_UUID, null)
    set(value) {
      sharedPreferences.edit().putString(PREF_USER_UUID, value).apply()
    }

  var id: Int
    get() = sharedPreferences.getInt(PREF_USER_ID, -1)
    set(value) {
      sharedPreferences.edit().putInt(PREF_USER_ID, value).apply()
    }

}

fun String.uuid(): UUID = this.let { UUID.fromString(it) }
