package com.naftarozklad.views.activities

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.widget.MultiAutoCompleteTextView
import butterknife.BindView
import com.naftarozklad.R
import com.naftarozklad.RozkladApp
import com.naftarozklad.presenters.MainPresenter
import com.naftarozklad.views.interfaces.MainView
import javax.inject.Inject

class MainActivity : AppCompatActivity(), MainView {

	@Inject
	lateinit var presenter: MainPresenter

	@BindView(R.id.et_search_field)
	lateinit var searchView: MultiAutoCompleteTextView

	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_main)

		RozkladApp.applicationComponent.inject(this)

		presenter.attachView(this)
	}
}
