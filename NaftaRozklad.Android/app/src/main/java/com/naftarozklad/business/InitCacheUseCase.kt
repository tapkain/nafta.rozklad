package com.naftarozklad.business

import com.naftarozklad.repo.external.WebApi
import com.naftarozklad.repo.internal.GlobalCache
import com.naftarozklad.utils.isNetworkAvailable
import org.jetbrains.anko.doAsync
import org.jetbrains.anko.uiThread
import javax.inject.Inject

/**
 * Created by bohdan on 10/4/17
 */

// BS: TODO: refactor

class InitCacheUseCase @Inject constructor(
		private val globalCache: GlobalCache,
		private val webApi: WebApi
) {

	fun isGroupsCacheEmpty() = globalCache.cachedGroups.isEmpty()

	fun initInternalRepo() = doAsync {
		globalCache.initDatabase()
	}

	fun initGroupsFromExternalRepo(callback: () -> Unit) {
		if (!isNetworkAvailable())
			return

		doAsync {
			val response = webApi.getGroups().execute()

			response.body()?.let {
				globalCache.clearGroups()
				val mutableResult = it.toMutableList()
				mutableResult.sortBy { it.id }
				globalCache.insertGroups(mutableResult)
			}

			uiThread { callback() }
		}
	}
}