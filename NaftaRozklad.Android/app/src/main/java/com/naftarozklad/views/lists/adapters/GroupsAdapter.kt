package com.naftarozklad.views.lists.adapters

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.ViewGroup
import com.naftarozklad.R
import com.naftarozklad.views.lists.viewmodels.GroupViewModel

/**
 * Created by bohdan on 10/7/17
 */
class GroupsAdapter(private val groupIds: List<Int>, private val bindAction: (GroupViewModel) -> Unit) : RecyclerView.Adapter<GroupViewModel>() {

	override fun onCreateViewHolder(parent: ViewGroup?, viewType: Int): GroupViewModel {
		return GroupViewModel(LayoutInflater.from(parent?.context).inflate(R.layout.list_item_group, parent, false))
	}

	override fun onBindViewHolder(holder: GroupViewModel?, position: Int) {
		holder?.let {
			holder.id = groupIds[position]
			bindAction(it)
		}
	}

	override fun getItemCount(): Int {
		return groupIds.size
	}
}