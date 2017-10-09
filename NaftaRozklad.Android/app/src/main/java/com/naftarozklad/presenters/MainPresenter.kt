package com.naftarozklad.presenters

import com.naftarozklad.business.InitCacheUseCase
import com.naftarozklad.business.MainUseCase
import com.naftarozklad.views.interfaces.MainView
import com.naftarozklad.views.lists.viewmodels.GroupViewModel
import javax.inject.Inject

/**
 * Created by bohdan on 10/4/17
 */
class MainPresenter @Inject constructor(
		private val mainUseCase: MainUseCase,
		private val initCacheUseCase: InitCacheUseCase
) : Presenter<MainView> {

	lateinit var mainView: MainView

	private val bindAction: (GroupViewModel) -> Unit = fun(viewModel) {
		viewModel.description.text = mainUseCase.getGroupById(viewModel.id)?.name
	}

	override fun attachView(view: MainView) {
		mainView = view

		mainView.setTextChangedAction { initList() }
		mainView.setRefreshAction { initFromExternalRepo() }

		initCacheUseCase.initInternalRepo {
			if (!initCacheUseCase.isGroupsCacheEmpty()) {
				initList()
				return@initInternalRepo
			}

			if (!mainUseCase.isNetworkAvailable()) {
				mainView.setNetworkAvailable(false)
				return@initInternalRepo
			}

			initFromExternalRepo()
		}
	}

	private fun initFromExternalRepo() {
		if (!mainUseCase.isNetworkAvailable()) {
			mainView.stopRefresh()
			return
		}

		initCacheUseCase.initGroupsFromExternalRepo {
			initList()
			mainView.stopRefresh()
			mainView.setNetworkAvailable(true)
		}
	}

	private fun initList() {
		mainView.setViewModelBindAction(mainUseCase.getGroupIds(mainView.getFilterText()), bindAction)
	}

	override fun detachView() {}
}