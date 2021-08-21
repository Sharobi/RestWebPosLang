package com.sharobi.webpos.roombooking.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.roombooking.adm.model.Amenities;
import com.sharobi.webpos.roombooking.adm.model.AmenitiesInfo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class AmenitiesService {
	
	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<AmenitiesInfo> getRoomAmenities(int storeId)
	{
		List<AmenitiesInfo> amenitiesList=new ArrayList<AmenitiesInfo>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_AMENITIES_GETAMENITIES).replace("{1}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			amenitiesList=gson.fromJson(responseString, new TypeToken<List<AmenitiesInfo>>() {}.getType());
			logger.debug("all menu sub category List fetched: {}", amenitiesList);
			return amenitiesList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addAmenities(Amenities amenities)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_AMENITIES_ADDAMENITIES);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(amenities));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editAmenities(Amenities amenities)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_AMENITIES_UPDATEAMENITIES);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(amenities));
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;	
		}
	}
	public String deleteAmenities(Amenities amenities)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_AMENITIES_DELETEAMENITIES);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(amenities));
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;	
		}
	}

}
