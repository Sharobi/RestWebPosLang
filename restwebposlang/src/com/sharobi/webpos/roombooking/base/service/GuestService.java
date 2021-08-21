package com.sharobi.webpos.roombooking.base.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.RequestBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.base.controller.RoomSearchController;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingInfo;
import com.sharobi.webpos.roombooking.base.model.UniqueIdTypeMaster;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class GuestService {
  private final static Logger logger = LogManager.getLogger(GuestService.class);
  private final static Gson gson = new Gson();

  // public final static String WEBSERVICE_BASE_ADD_ROOM_BOOKING_GUEST =
  // "webservice.base.room.addRoomBookingGuest";
  // public final static String WEBSERVICE_BASE_GET_ROOM_BOOKING_GUEST=
  // "webservice.base.room.getRoomBookingGuest";
  public String addRoomBookingGuest(RoomBooking roomBooking) throws IOException {
    try {
      /*http://192.168.1.34:8082/Restaurant/rest/roomsearch/addRoomBookingGuest
*/     
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ADD_ROOM_BOOKING_GUEST);
      logger.debug("url for adding guest in GuestService Is....{}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(roomBooking));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }

  
  public String getRoomGuestByBookingId( String bookingId,String storeId){
    String responseString =null;
    /*url=http://192.168.1.34:8082/Restaurant/rest/roomsearch/getRoomGuestByBookingId?bookingId=3&hotelId=29
*/    
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_GET_ROOM_BOOKING_GUEST)
              .replace("{1}", String.valueOf(bookingId)).replace("{2}", String.valueOf(storeId)));
      ClientResponse response = WebServiceClient.callGet(url);
      responseString = response.getEntity(String.class);
      logger.debug("url in getRoomGuestByBookingId...{}",url);
      logger.debug("response string in getRoomGuestByBookingId ...{}",responseString);
    
    } catch (Exception e) {
      logger.error("Exception: ", e);
      //return null;
    }
    return responseString;
  }
  
  public String getAllUniqueIdType(int storeId) {
   
    try{
      /*http://192.168.1.34:8082/Restaurant/rest/order/getUniqueIdTypeByStore?storeid=29
*/     
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_ROOMMGNT_CUSTOMER_GETCUSTOMERIDTYPES).replace("{1}",String.valueOf(storeId));
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
     
      logger.debug("getAllUniqueIdType In GuestService Is: {}", responseString);
      return responseString;
    }catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
    }
  
  
}
