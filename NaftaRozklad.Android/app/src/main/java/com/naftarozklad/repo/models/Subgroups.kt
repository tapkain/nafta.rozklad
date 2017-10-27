package com.naftarozklad.repo.models


import com.naftarozklad.R
import com.naftarozklad.utils.resolveString

/**
 * Created by bohdan on 10/7/17
 */
enum class Subgroups(val id: Int, val description: String) {
	FIRST(1, resolveString(R.string.lbl_first_subgroup)), SECOND(2, resolveString(R.string.lbl_second_subgroup))
}