package com.sharobi.webpos.roombooking.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.sharobi.webpos.roombooking.adm.model.RoomAmenitiesMapInfo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class RoomTypeAmenitiesMgntService {
	private final static Logger logger=LogManager.getLogger(RoomTypeAmenitiesMgntService.class);
	private final static Gson gson=new Gson();
	
	public String getRoomAmenitiesMapToRoomType(String roomTypeId, int storeId)
	{
		List<RoomAmenitiesMapInfo> amenitiesList=new ArrayList<RoomAmenitiesMapInfo>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMTYPE_AMENITIES_GETAMENITIESMAPINFO).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(roomTypeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	

	public String assignAmenitiesRoomTypeMap(List<RoomAmenitiesMapInfo> mapSetup)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMTYPE_AMENITIES_ASSIGNAMENITIESMAPINFO);
			logger.debug("url....{}{}",gson.toJson(mapSetup),url);
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(mapSetup));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String updateAmenitiesRoomTypeMap(List<RoomAmenitiesMapInfo> mapSetup)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMTYPE_AMENITIES_UPDATEAMENITIESMAPINFO);
			logger.debug("url....{}",gson.toJson(mapSetup));
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(mapSetup));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
}
