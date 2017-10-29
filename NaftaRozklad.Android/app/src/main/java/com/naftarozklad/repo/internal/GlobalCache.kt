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

	fun insertGroups(groups: List<Group>) {
		cachedGroups = groups.sortedBy { it.id }.toMutableList()
		dbManager.rozkladDatabase.groupsDAO().clearGroups()
		dbManager.rozkladDatabase.groupsDAO().insertGroups(groups)
	}
}