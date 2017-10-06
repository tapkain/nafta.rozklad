package com.naftarozklad.repo.models

import android.arch.persistence.room.Entity

/**
 * Created by Bohdan.Shvets on 05.10.2017
 */
@Entity
class Lesson {

	var period:Int = 0

	var week:Int = 0

	var subgroup:Int = 0

	lateinit var type:String

	lateinit var name:String

	lateinit var teacher:String
}