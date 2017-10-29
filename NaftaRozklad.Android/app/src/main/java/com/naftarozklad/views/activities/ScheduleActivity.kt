package com.naftarozklad.views.activities

import android.os.Bundle
import android.os.PersistableBundle
import android.support.v7.app.AppCompatActivity
import com.naftarozklad.R
import com.naftarozklad.views.interfaces.ScheduleView

/**
 * Created by bohdan on 10/7/17
 */
class ScheduleActivity : AppCompatActivity(), ScheduleView {

	override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
		super.onCreate(savedInstanceState, persistentState)
		setContentView(R.layout.activity_shedule)
	}
}