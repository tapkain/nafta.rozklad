package com.naftarozklad.presenters

import com.naftarozklad.business.InitCacheUseCase
import com.naftarozklad.business.MainUseCase
import com.naftarozklad.views.interfaces.GroupsView
import javax.inject.Inject

/**
 * Created by bohdan on 10/4/17
 */
class GroupsPresenter @Inject constructor(
		private val mainUseCase: MainUseCase,
		private val initCacheUseCase: InitCacheUseCase
) : Presenter<GroupsView> {

	lateinit var groupsView: GroupsView

	override fun attachView(view: GroupsView) {
		groupsView = view

		groupsView.setTextChangedAction { initList() }
		groupsView.setRefreshAction { initFromExternalRepo() }

		initCacheUseCase.initInternalRepo {
			if (!initCacheUseCase.isGroupsCacheEmpty()) {
				initList()
				return@initInternalRepo
			}

			if (!mainUseCase.isNetworkAvailable()) {
				groupsView.networkUnavailable()
				return@initInternalRepo
			}

			initFromExternalRepo()
		}
	}

	private fun initFromExternalRepo() {
		if (!mainUseCase.isNetworkAvailable()) {
			groupsView.stopRefresh()
			return
		}

		initCacheUseCase.initGroupsFromExternalRepo {
			initList()
			groupsView.stopRefresh()
		}
	}

	private fun initList() {
		groupsView.setListItems(mainUseCase.getGroups(groupsView.getFilterText()))
	}

	override fun detachView() {}
}