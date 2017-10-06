package com.naftarozklad.presenters

import com.naftarozklad.business.InitCacheUseCase
import com.naftarozklad.business.MainUseCase
import com.naftarozklad.views.interfaces.MainView
import javax.inject.Inject

/**
 * Created by bohdan on 10/4/17
 */
class MainPresenter @Inject constructor(
		private val mainUseCase: MainUseCase,
		private val initCacheUseCase: InitCacheUseCase
) : Presenter<MainView> {

	override fun attachView(view: MainView) {
		initCacheUseCase.initCache {
			
		}
	}

	override fun detachView() {

	}
}