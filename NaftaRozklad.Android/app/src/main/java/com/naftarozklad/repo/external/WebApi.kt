package com.naftarozklad.repo.external

import com.naftarozklad.repo.models.Group
import retrofit2.Call
import retrofit2.http.GET

/**
 * Created by Bohdan.Shvets on 04.10.2017
 */
interface WebApi {

	@GET("api/groups.php")
	fun getGroups(): Call<Array<Group>>
}