package com.naftarozklad.repo.models

import android.arch.persistence.room.Entity
import android.arch.persistence.room.Ignore

/**
 * Created by Bohdan.Shvets on 05.10.2017
 */
@Entity
class Day {

	@Ignore
	lateinit var lessons:Array<Lesson>

	var day:Int = 0
}