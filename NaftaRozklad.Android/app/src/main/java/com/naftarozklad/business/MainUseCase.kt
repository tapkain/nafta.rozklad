package com.naftarozklad.business

import com.naftarozklad.repo.external.WebApi
import com.naftarozklad.repo.internal.GlobalCache
import com.naftarozklad.repo.models.Group
import com.naftarozklad.utils.NetworkHelper
import javax.inject.Inject

/**
 * Created by bohdan on 10/4/17
 */
class MainUseCase @Inject constructor(private val globalCache: GlobalCache, private val webApi: WebApi) {

	fun getGroupById(groupId: Int): Group? = globalCache.cachedGroups.find { it.id == groupId }

	fun getGroupIds(filterString: String): List<Int> {
		return globalCache.cachedGroups
				.filter { it.name.contains(filterString, true) }
				.map { it.id }
	}

	fun isNetworkAvailable(): Boolean {
		return NetworkHelper.isNetworkAvailable()
	}
}