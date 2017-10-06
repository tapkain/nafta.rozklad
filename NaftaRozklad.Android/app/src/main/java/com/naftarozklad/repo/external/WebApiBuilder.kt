package com.naftarozklad.repo.external

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */
class WebApiBuilder {

	val BASE_URL = "http://rozklad.nung.edu.ua/application/"

	fun createWebApi(): WebApi {
		val builder = Retrofit.Builder()
				.baseUrl(BASE_URL)
				.addConverterFactory(GsonConverterFactory.create())
				.build()

		return builder.create(WebApi::class.java)
	}
}