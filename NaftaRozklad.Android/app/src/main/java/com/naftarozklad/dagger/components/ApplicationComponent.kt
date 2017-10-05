package com.naftarozklad.dagger.components

import com.naftarozklad.dagger.modules.CacheModule
import com.naftarozklad.dagger.modules.RetrofitModule
import com.naftarozklad.views.activities.MainActivity
import dagger.Component
import javax.inject.Singleton

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */
@Singleton
@Component(modules = arrayOf(CacheModule::class, RetrofitModule::class))
interface ApplicationComponent {

	fun inject(activity: MainActivity)
}