package com.sharobi.webpos.roombooking.adm.service;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.roombooking.adm.model.RoomServices;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;


public class RoomService_Service {
	
	private final static Logger logger=LogManager.getLogger(RoomTypeAmenitiesMgntService.class);
	private final static Gson gson=new Gson();
	public List<RoomServices> getRoomService(int storeId)
	{
		List<RoomServices> roomservicesList=new ArrayList<RoomServices>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMSERVICES_GETROOMSERVICES).replace("{1}",String.valueOf(storeId));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			roomservicesList=gson.fromJson(responseString, new TypeToken<List<RoomServices>>() {}.getType());
			logger.debug("all menu sub category List fetched: {}", roomservicesList);
			return roomservicesList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String addRoomServices(RoomServices roomservices)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMSERVICES_ADDROOMSERVICES);
			//url=url.replaceAll(" ", "%20");
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(roomservices));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String editRoomServices(RoomServices roomservices)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMSERVICES_EDITROOMSERVICES);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(roomservices));
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
	
	public String deleteRoomServices(RoomServices roomservices)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMMGNT_ROOMSERVICES_DELETEROOMSERVICES);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(roomservices));
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

  public List<RoomBooking> getBills(String checkInDate, String checkoutDate, int storeId) {
    List<RoomBooking> bills=new ArrayList<RoomBooking>();
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_ROOM_BILLREGISTER).replace("{1}",checkInDate).replace("{2}",checkoutDate).replace("{3}",String.valueOf(storeId));
      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      bills=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
      logger.debug("all bills: {}", bills);
      return bills;
    }catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  }

}

