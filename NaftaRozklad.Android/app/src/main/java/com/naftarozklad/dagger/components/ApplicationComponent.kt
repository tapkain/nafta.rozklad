package com.naftarozklad.dagger.components

import android.content.Context
import com.naftarozklad.dagger.modules.ApplicationModule
import com.naftarozklad.dagger.modules.CacheModule
import com.naftarozklad.dagger.modules.RetrofitModule
import com.naftarozklad.views.activities.GroupsActivity
import com.naftarozklad.views.activities.ScheduleActivity
import dagger.Component
import javax.inject.Singleton

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */
@Singleton
@Component(modules = arrayOf(CacheModule::class, RetrofitModule::class, ApplicationModule::class))
interface ApplicationComponent {
	fun  context(): Context

	fun inject(activity: GroupsActivity)

	fun inject(activity: ScheduleActivity)
}