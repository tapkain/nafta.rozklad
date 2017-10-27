package com.naftarozklad.views.activities

import android.os.Bundle
import android.support.design.widget.Snackbar
import android.support.v7.app.AppCompatActivity
import android.support.v7.widget.LinearLayoutManager
import com.naftarozklad.R
import com.naftarozklad.RozkladApp
import com.naftarozklad.presenters.GroupsPresenter
import com.naftarozklad.repo.models.Group
import com.naftarozklad.utils.SimpleTextWatcher
import com.naftarozklad.views.interfaces.GroupsView
import com.naftarozklad.views.lists.adapters.GroupsAdapter
import kotlinx.android.synthetic.main.activity_groups.*
import org.jetbrains.anko.contentView
import javax.inject.Inject

class GroupsActivity : AppCompatActivity(), GroupsView {

	@Inject
	lateinit var presenter: GroupsPresenter

	private val adapter = GroupsAdapter()

	private lateinit var textChangedAction: (String) -> Unit

	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_groups)
		RozkladApp.applicationComponent.inject(this)

		recyclerView.layoutManager = LinearLayoutManager(this)
		recyclerView.adapter = adapter

		presenter.attachView(this)

		etSearch.addTextChangedListener(object : SimpleTextWatcher() {
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

	override fun setListItems(groups: List<Group>) {
		adapter.setGroups(groups)
	}

	override fun stopRefresh() {
		swipeRefreshLayout.isRefreshing = false
	}

	override fun getFilterText() = etSearch.text.toString()

	override fun setFilterText(filterText: String) = etSearch.setText(filterText)

	override fun onError(errorMessage: String) {
		contentView?.let { Snackbar.make(it, errorMessage, Snackbar.LENGTH_SHORT) }
	}
}
