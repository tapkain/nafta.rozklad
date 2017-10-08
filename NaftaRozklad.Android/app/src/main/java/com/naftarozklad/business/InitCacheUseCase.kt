package com.naftarozklad.business

import com.naftarozklad.repo.external.WebApi
import com.naftarozklad.repo.internal.GlobalCache
import com.naftarozklad.utils.NetworkHelper
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

	fun isGroupsCacheEmpty(): Boolean {
		return globalCache.cachedGroups.isEmpty()
	}

	fun initInternalRepo(callback: () -> Unit) {
		doAsync {
			globalCache.initDatabase {
				uiThread { callback() }
			}
		}
	}

	fun initGroupsFromExternalRepo(callback: () -> Unit) {
		if (!NetworkHelper().isNetworkAvailable())
			return

		doAsync {
			val response = webApi.getGroups().execute()

			response.body()?.let {
				globalCache.clearGroups()
				globalCache.insertGroups(it.toMutableList())
			}

			callback()
		}
	}
}