package com.sharobi.webpos.roombooking.base.service;


import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingPayment;
import com.sharobi.webpos.roombooking.base.model.RoomBookingServices;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class CheckOutService {
	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<RoomBooking> getAllcheckIncustomer(String fromDate,String toDate, int storeId, String bookingNo)
	{
		List<RoomBooking> checkIdlist=new ArrayList<RoomBooking>();
		try{
			
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLCHECKIN_BYDATEPERIOD).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(toDate)).replace("{3}",String.valueOf(storeId)).replace("{4}",bookingNo);
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			checkIdlist=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched: {}", checkIdlist+"::respos json:"+responseString);
			
			return checkIdlist;
			
		}
		catch(Exception ex){
			
			logger.debug("Exception",ex);
			return null;
		}
	
		
	}
	
	public List<RoomBooking> getBookingIdByCustIdByPeriod(String fromDate,String toDate,int storeId,String custId)
	{
		List<RoomBooking> bookingIdListByPeriod=new ArrayList<RoomBooking>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLBOOKINGID_BYCUSTID).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(toDate)).replace("{3}",String.valueOf(storeId)).replace("{4}",String.valueOf(custId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			bookingIdListByPeriod=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched: {}", bookingIdListByPeriod);
			return bookingIdListByPeriod;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	
	public List<RoomBooking>getBookDetListbyBookId(String resId,int storeId)
	{
		List<RoomBooking> reserveIdDetails=new ArrayList<RoomBooking>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLBOOKINGDETAILS_BYBOOKINGID).replace("{1}",String.valueOf(resId)).replace("{2}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			reserveIdDetails=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched: {}", reserveIdDetails);
			return reserveIdDetails;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	
	public String getBookingIdByBookingId(int storeId,String resId,String fromDate,String toDate){
		
		try{
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETBOOKINGIDLIST_BYBOOKINGID).replace("{1}", String.valueOf(resId)).replace("{2}", String.valueOf(storeId)).replace("{3}", String.valueOf(fromDate)).replace("{4}", String.valueOf(toDate)));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get Reserve details info: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String checkOutRoom(RoomBooking RoomBookingDetails)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_CHECKOUT);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(RoomBookingDetails));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}

	public String changeCheckout(RoomBooking rmbooking) {
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_CHECKOUT_UPDATE);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(rmbooking));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}

	public String setDiscount(RoomBooking rmbooking) {
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_ADD_DISCOUNT);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(rmbooking));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}

	public List<RoomBooking> getBookDetListbyBookIdforfinalbill(String bookId, int storeId) {
		List<RoomBooking> reserveIdDetails=new ArrayList<RoomBooking>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLBOOKINGDETAILS_BYBOOKINGID_FORFINALBILL).replace("{1}",String.valueOf(bookId)).replace("{2}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			reserveIdDetails=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched for final bill: {}", reserveIdDetails);
			return reserveIdDetails;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}

  
  public String changeTax(RoomBooking roombookingobj) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_TAXCHANGE);

      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callPost(url,gson.toJson(roombookingobj));
      String responseString=response.getEntity(String.class);
      return responseString;
    }
    catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  }

  public String addRoomServices(RoomBooking roomBooking) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_ADDSERVICES);

      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callPost(url,gson.toJson(roomBooking));
      String responseString=response.getEntity(String.class);
      return responseString;
    }
    catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  }

  public String getRoomServiceInfoByBookingId(int bookingId , int hotelId) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETSERVICES_BYBOOKINGID).replace("{1}", String.valueOf(bookingId)).replace("{2}", String.valueOf(hotelId));
      logger.debug("url....{}",url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      logger.debug("Response string in getRoomServiceInfoByBookingId: {}", responseString);
      return responseString;
    }catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  }
	
	

}
