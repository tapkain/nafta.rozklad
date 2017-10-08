package com.naftarozklad.repo.models

import android.arch.persistence.room.Entity
import android.arch.persistence.room.PrimaryKey

/**
 * Created by Bohdan.Shvets on 05.10.2017
 */
@Entity(tableName = "lessons")
class Lesson {

	@PrimaryKey
	var id: Int = 0

	var period:Int = 0

	var day:Int = 0

	var week:Int = 0

	var subgroup:Int = 0

	lateinit var type:String

	lateinit var name:String

	lateinit var teacher:String
}