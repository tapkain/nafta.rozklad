package com.naftarozklad.repo.models

import com.google.gson.annotations.SerializedName

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */

class Group() {
	lateinit var name: String
	var id: Int = 0
	lateinit var faculty: String
	@SerializedName("has_subgroups")
	var hasSubgroups: Boolean = false
}