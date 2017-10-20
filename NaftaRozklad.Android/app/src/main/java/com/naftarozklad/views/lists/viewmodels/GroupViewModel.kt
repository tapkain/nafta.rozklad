package com.naftarozklad.views.lists.viewmodels

import android.support.v7.widget.RecyclerView
import android.view.View
import kotlinx.android.synthetic.main.list_item_group.view.*

/**
 * Created by bohdan on 10/7/17
 */
class GroupViewModel(view: View) : RecyclerView.ViewHolder(view) {

	var id: Int = 0

	var description: String? = ""
		set(value) {
			itemView.tvDescription.text = value
		}
}