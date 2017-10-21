package com.naftarozklad.views.lists.adapters

import android.support.v7.util.DiffUtil
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.naftarozklad.R
import com.naftarozklad.repo.models.Group
import com.naftarozklad.utils.GroupsDiffCallback
import kotlinx.android.synthetic.main.list_item_group.view.*

/**
 * Created by bohdan on 10/7/17
 */
class GroupsAdapter : RecyclerView.Adapter<GroupsAdapter.GroupViewModel>() {

	private var groups: MutableList<Group> = ArrayList()

	override fun onCreateViewHolder(parent: ViewGroup?, viewType: Int): GroupViewModel {
		return GroupViewModel(LayoutInflater.from(parent?.context).inflate(R.layout.list_item_group, parent, false))
	}

	override fun onBindViewHolder(holder: GroupViewModel?, position: Int) {
		holder?.description = groups[position].name
	}

	override fun getItemCount(): Int {
		return groups.size
	}

	fun setGroups(groups: List<Group>) {
		val result = DiffUtil.calculateDiff(GroupsDiffCallback(this.groups, groups))

		this.groups.clear()
		this.groups.addAll(groups)

		result.dispatchUpdatesTo(this)
	}

	class GroupViewModel(view: View) : RecyclerView.ViewHolder(view) {

		var id: Int = 0

		var description: String? = ""
			set(value) {
				itemView.tvDescription.text = value
			}
	}
}