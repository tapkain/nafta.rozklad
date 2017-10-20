package com.naftarozklad.views.activities

import android.os.Bundle
import android.support.design.widget.Snackbar
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import android.text.Editable
import android.text.TextWatcher
import com.naftarozklad.R
import com.naftarozklad.RozkladApp
import com.naftarozklad.presenters.MainPresenter
import com.naftarozklad.views.interfaces.MainView
import com.naftarozklad.views.lists.adapters.GroupsAdapter
import com.naftarozklad.views.lists.viewmodels.GroupViewModel
import kotlinx.android.synthetic.main.activity_main.*
import org.jetbrains.anko.contentView
import javax.inject.Inject

class MainActivity : AppCompatActivity(), MainView {

	@Inject
	lateinit var presenter: MainPresenter

	private lateinit var textChangedAction: (String) -> Unit

	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_main)
		RozkladApp.applicationComponent.inject(this)

		recyclerView.layoutManager = LinearLayoutManager(this)

		presenter.attachView(this)

		etSearch.addTextChangedListener(object : TextWatcher {
			override fun afterTextChanged(s: Editable?) {}

			override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

			override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
				s?.toString()?.let { text -> textChangedAction(text) }
			}
		})
	}

	override fun setTextChangedAction(action: (String) -> Unit) {
		textChangedAction = action
	}

	override fun setRefreshAction(action: () -> Unit) {
		swipeRefreshLayout.setOnRefreshListener(action)
	}

	override fun setViewModelBindAction(groupIds: List<Int>, bindAction: (GroupViewModel) -> Unit) {
		recyclerView.adapter = GroupsAdapter(groupIds, bindAction)
	}

	override fun networkUnavailable() {
		contentView?.let { Snackbar.make(it, "No Internet Connection", Snackbar.LENGTH_SHORT) }
	}

	override fun stopRefresh() {
		swipeRefreshLayout.isRefreshing = false
	}

	override fun getFilterText() = etSearch.text.toString()

	override fun setFilterText(filterText: String) = etSearch.setText(filterText)
}
