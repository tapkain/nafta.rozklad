package com.naftarozklad.utils

import android.content.Context
import android.net.ConnectivityManager
import com.naftarozklad.RozkladApp

/**
 * Created by Bohdan.Shvets on 05.10.2017
 */
class NetworkHelper {

	fun isNetworkAvailable(): Boolean {
		val connectivityManager = RozkladApp.applicationComponent.context().getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager;
		val activeNetworkInfo = connectivityManager.activeNetworkInfo;
		return activeNetworkInfo != null && activeNetworkInfo.isConnected;
	}
}