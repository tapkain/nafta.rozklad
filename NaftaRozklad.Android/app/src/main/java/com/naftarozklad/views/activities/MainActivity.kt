package com.naftarozklad.views.activities

import android.os.Bundle
import android.support.v4.widget.SwipeRefreshLayout
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.AppCompatEditText
import android.support.v7.widget.LinearLayoutManager
import android.support.v7.widget.RecyclerView
import butterknife.BindView
import butterknife.ButterKnife
import butterknife.OnTextChanged
import com.naftarozklad.R
import com.naftarozklad.RozkladApp
import com.naftarozklad.presenters.MainPresenter
import com.naftarozklad.views.interfaces.MainView
import com.naftarozklad.views.lists.adapters.GroupsAdapter
import com.naftarozklad.views.lists.viewmodels.GroupViewModel
import javax.inject.Inject

class MainActivity : AppCompatActivity(), MainView {

	@Inject
	lateinit var presenter: MainPresenter

	@BindView(R.id.swipe_refresh_layout)
	lateinit var swipeRefreshLayout: SwipeRefreshLayout
	@BindView(R.id.et_search)
	lateinit var searchView: AppCompatEditText
	@BindView(R.id.recycler_view)
	lateinit var recyclerView: RecyclerView

	private lateinit var textChangedAction: (String) -> Unit
	private lateinit var refreshAction: () -> Unit

	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_main)
		ButterKnife.bind(this)
		RozkladApp.applicationComponent.inject(this)

		recyclerView.layoutManager = LinearLayoutManager(this)

		swipeRefreshLayout.setOnRefreshListener(refreshAction)

		presenter.attachView(this)
	}

	override fun setTextChangedAction(action: (String) -> Unit) {
		textChangedAction = action
	}

	override fun setRefreshAction(action: () -> Unit) {
		refreshAction = action
	}

	override fun setViewModelBindAction(groupIds: List<Int>, bindAction: (GroupViewModel) -> Unit) {
		recyclerView.adapter = GroupsAdapter(groupIds, bindAction)
		swipeRefreshLayout.isRefreshing
	}

	override fun getFilterText(): String {
		return searchView.text.toString()
	}

	override fun setFilterText(filterText: String) {
		searchView.setText(filterText)
	}

	@OnTextChanged(R.id.et_search)
	fun searchTextChanged(text: CharSequence) {
		textChangedAction(text.toString())
	}
}
