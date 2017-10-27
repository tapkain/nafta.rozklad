package com.naftarozklad.repo.internal

import com.naftarozklad.repo.internal.db.DBManager
import com.naftarozklad.repo.models.Group
import javax.inject.Inject

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */
class GlobalCache @Inject constructor(private var dbManager: DBManager) {

	lateinit var cachedGroups: MutableList<Group>

	fun initDatabase() {
		dbManager.initDatabase()
		cachedGroups = dbManager.rozkladDatabase.groupsDAO().getGroups().toMutableList()
	}

	fun clearGroups() {
		cachedGroups.clear()
		dbManager.rozkladDatabase.groupsDAO().clearGroups()
	}

	fun insertGroups(groups: MutableList<Group>) {
		cachedGroups = groups
		dbManager.rozkladDatabase.groupsDAO().insertGroups(groups)
	}
}