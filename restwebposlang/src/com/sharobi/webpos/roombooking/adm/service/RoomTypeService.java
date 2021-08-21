package com.sharobi.webpos.roombooking.adm.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.roombooking.adm.model.RoomBookingType;
import com.sharobi.webpos.roombooking.adm.model.RoomType;
import com.sharobi.webpos.roombooking.adm.model.RoomTypeInfo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
@Service
public class RoomTypeService {
	
	
	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<RoomType> getRoomTypeByStoreId(int storeId)
	{
		List<RoomType> roomtypeList=new ArrayList<RoomType>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMTYPE_GETROOMTYPES).replace("{1}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			roomtypeList=gson.fromJson(responseString, new TypeToken<List<RoomType>>() {}.getType());
			logger.debug("all menu sub category List fetched: {}", roomtypeList);
			return roomtypeList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String addRoomType(RoomTypeInfo roomType)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMTYPE_ADDROOMTYPES);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(roomType));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String editRoomType(RoomTypeInfo roomType)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMTYPE_EDITROOMTYPES);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(roomType));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	public String deleteRoomType(RoomTypeInfo roomType)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMTYPE_DELETEROOMTYPES);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(roomType));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
  public List<RoomBookingType> getRoomBookingTypeByStoreId(int storeId) {
    List<RoomBookingType> roombookingtypeList=new ArrayList<RoomBookingType>();
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETROOMBOOKINGTYPE).replace("{1}",String.valueOf(storeId));
      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      roombookingtypeList=gson.fromJson(responseString, new TypeToken<List<RoomBookingType>>() {}.getType());
      logger.debug("all roombookingtypeList List fetched: {}", roombookingtypeList);
      return roombookingtypeList;
    }catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  }
	
}
