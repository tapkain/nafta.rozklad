package com.naftarozklad.business

import com.naftarozklad.R
import com.naftarozklad.repo.external.WebApi
import com.naftarozklad.repo.internal.GlobalCache
import com.naftarozklad.utils.isNetworkAvailable
import com.naftarozklad.utils.resolveErrorMessage
import com.naftarozklad.utils.resolveString
import org.jetbrains.anko.doAsync
import javax.inject.Inject

/**
 * Created by Bohdan.Shvets on 27.10.2017
 */

class SynchronizeGroupsUseCase @Inject constructor(
		private val webApi: WebApi,
		private val globalCache: GlobalCache
) {

	fun synchronizeGroups(callback: SynchronizeCallback?) = doAsync {
		if (!isNetworkAvailable()) {
			callback?.onError(resolveString(R.string.lbl_no_network))
			return@doAsync
		}

		with(webApi.getGroups().execute()) {
			val groups = body()

			if (isSuccessful && groups != null) {
				globalCache.insertGroups(groups.toMutableList())
				callback?.onSuccess()
			} else {
				callback?.onError(resolveErrorMessage(code()))
			}
		}
	}
}