package com.naftarozklad.business

import android.os.AsyncTask
import com.naftarozklad.repo.external.WebApi
import com.naftarozklad.repo.internal.GlobalCache
import com.naftarozklad.utils.NetworkHelper
import javax.inject.Inject

/**
 * Created by bohdan on 10/4/17
 */

class InitCacheUseCase @Inject constructor(private val globalCache: GlobalCache, private val webApi: WebApi) {

	fun initCache(callback: () -> Unit) {
		if (!NetworkHelper().isNetworkAvailable())
			return

		AsyncTask.SERIAL_EXECUTOR.execute {
			val response = webApi.getGroups().execute()

			response.body()?.let {
				globalCache.cachedGroups = it
			}

			callback()
		}
	}
}