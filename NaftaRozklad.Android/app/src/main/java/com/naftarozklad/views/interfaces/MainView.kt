package com.naftarozklad.views.interfaces

import com.naftarozklad.views.lists.viewmodels.GroupViewModel

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */
interface MainView : View {

	fun setTextChangedAction(action: (String) -> Unit)

	fun setViewModelBindAction(groupIds: List<Int>, bindAction: (GroupViewModel) -> Unit)

	fun getFilterText(): String

	fun setFilterText(filterText: String)

	fun setRefreshAction(action: () -> Unit)
}