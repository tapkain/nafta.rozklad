package com.naftarozklad.business

import com.naftarozklad.R
import com.naftarozklad.repo.external.WebApi
import com.naftarozklad.repo.internal.GlobalCache
import com.naftarozklad.repo.models.Lesson
import com.naftarozklad.repo.models.Subgroups
import com.naftarozklad.repo.models.Weeks
import com.naftarozklad.utils.isNetworkAvailable
import com.naftarozklad.utils.resolveErrorMessage
import com.naftarozklad.utils.resolveString
import org.jetbrains.anko.doAsync
import org.jetbrains.anko.uiThread
import javax.inject.Inject

/**
 * Created by Bohdan.Shvets on 30.10.2017
 */
class SynchronizeLessonsUseCase @Inject constructor(
		private val webApi: WebApi,
		private val globalCache: GlobalCache
) {

	fun syncronizeLessons(groupId: Int, callback: SynchronizeCallback?) = doAsync {
		if (!isNetworkAvailable()) {
			uiThread { callback?.onError(resolveString(R.string.lbl_no_network)) }
			return@doAsync
		}

		val lessons = HashSet<Lesson>()

		var result = webApi.getSchedule(groupId = groupId, week = Weeks.NUMERATOR.id, subgroup = Subgroups.FIRST.id).execute()
		if (!result.isSuccessful) {
			uiThread { callback?.onError(resolveErrorMessage(result.code())) }
			return@doAsync
		}

//		lessons.addAll(result.body())

		result = webApi.getSchedule(groupId = groupId, week = Weeks.DENOMINATOR.id, subgroup = Subgroups.FIRST.id).execute()
		if (!result.isSuccessful) {
			uiThread { callback?.onError(resolveErrorMessage(result.code())) }
			return@doAsync
		}
	}
}