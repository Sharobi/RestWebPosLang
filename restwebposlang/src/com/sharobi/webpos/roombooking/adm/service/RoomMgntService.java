package com.sharobi.webpos.roombooking.adm.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.adm.model.RoomInfo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class RoomMgntService {
	
	private final static Logger logger=LogManager.getLogger(RoomTypeAmenitiesMgntService.class);
	private final static Gson gson=new Gson();
	
	
	
	public List<Room> getRoom(int storeId)
	{
		List<Room> roomList=new ArrayList<Room>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOM_GETROOM).replace("{1}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			roomList=gson.fromJson(responseString, new TypeToken<List<Room>>() {}.getType());
			logger.debug("all menu sub category List fetched: {}", roomList);
			return roomList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String addRoom(RoomInfo room)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOM_ADDROOM);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(room));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String editRoom(RoomInfo room)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOM_EDITROOM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(room));
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

	
	public String deleteRoom(RoomInfo room)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOM_DELETEROOM);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(room));
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
