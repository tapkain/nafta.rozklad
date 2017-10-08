package com.naftarozklad.views.lists.viewmodels

import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.TextView
import butterknife.BindView
import butterknife.ButterKnife
import com.naftarozklad.R

/**
 * Created by bohdan on 10/7/17
 */
class GroupViewModel(view: View): RecyclerView.ViewHolder(view) {

	var id: Int = 0

	@BindView(R.id.tv_description)
	lateinit var description: TextView

	init {
		ButterKnife.bind(this, itemView)
	}
}