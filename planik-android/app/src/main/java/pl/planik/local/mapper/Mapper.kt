package pl.planik.local.mapper

internal interface Mapper<in T, out R> {
  fun map(value: T): R
}

