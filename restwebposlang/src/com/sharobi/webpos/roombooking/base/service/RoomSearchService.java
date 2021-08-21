package com.sharobi.webpos.roombooking.base.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;



import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;


import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Payment;
import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingInfo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.multipart.MultiPart;

public class RoomSearchService {

	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<Room> getRoomListBySearch(String fromDate, String toDate, int storeId)
	{
		List<Room> roomList=new ArrayList<Room>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETROOMBYSEARCHCRITERIA).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(toDate)).replace("{3}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			roomList=gson.fromJson(responseString, new TypeToken<List<Room>>() {}.getType());
			logger.debug("all room List fetched: {}", roomList);
			return roomList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String reserveRoom(RoomBookingInfo RoomBookingDetails)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOM_RESERVEROOM_POST);
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

  public String getAvailableRoomListForChange(String fromDate, String toDate, int storeId) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETROOMBYSEARCHCRITERIA).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(toDate)).replace("{3}",String.valueOf(storeId));
      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      return responseString;
     }catch(Exception ex)
      {
      logger.debug("Exception",ex);
      return null;
    }
  }

  public String getSelectedRoomDetails(String roomId, int storeId) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETRROMDETAILSBYID).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(roomId));
      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      return responseString;
     }catch(Exception ex)
      {
      logger.debug("Exception",ex);
      return null;
    }
  }

  public String changeRoom(String newRoomId, String oldRoomId, String reserveId, String bookingId, String newRoomRate, String taxId, String taxRate, int storeId) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_CHANGEROOM).replace("{1}",String.valueOf(reserveId)).replace("{2}",String.valueOf(bookingId)).replace("{3}",String.valueOf(storeId)).replace("{4}",String.valueOf(oldRoomId)).replace("{5}",String.valueOf(newRoomId)).replace("{6}",String.valueOf(newRoomRate)).replace("{7}",String.valueOf(taxId)).replace("{8}",String.valueOf(taxRate));
      System.out.println("url:"+url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      return responseString;
     }catch(Exception ex)
      {
      logger.debug("Exception",ex);
      return null;
    }
  }

  public String getCustomerDetailsByPhoneOrName(String storeId,String searchterm,Boolean is_phone) throws Exception {
    String url="";
    /*URL FOR SEARCH BY CUSTOMER  PHONE NUMBER FOR ROOMBOOKING IS:
      http://192.168.1.34:8082/Restaurant/rest/storeCustomer/getAllRBStoreCustomerByPhNmbr?storeId={1}&phone={2}


      URL FOR SEARCH BY CUSTOMER NAME FOR ROOM BOOKING IS:
      http://192.168.1.34:8082/Restaurant/rest/storeCustomer/getAllRBStoreCustomerByName?storeId={1}&name={2}
*/    
    try{
      String phoneurl=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMBOOKING_GETCUSTOMERDETAILS_BYPHNO).replace("{1}", String.valueOf(storeId))).replace("{2}", String.valueOf(searchterm));
      String nameurl=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMBOOKING_GETCUSTOMERDETAILS_BYNAME).replace("{1}", String.valueOf(storeId))).replace("{2}", String.valueOf(searchterm));
      url=(is_phone!=null && is_phone)?phoneurl:nameurl;
      logger.debug("url  ....{} ",url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      return responseString;
     }catch(Exception ex)
      {
      logger.debug("Exception",ex);
      return null;
    }
    
  }
  
  
  public String getCreditBookingByCustomerId(String storeId,String custId) throws Exception {
    String url="";
    List<RoomBooking>roombookingList=null;
    //List<RoomBooking>roombookingListResponse=new ArrayList<RoomBooking>();
   // double netAmountToPay=00.00;
   // double netadvanceamount=00.00;
    /*URL FOR THIS IS=
        http://192.168.1.34:8082/Restaurant/rest/roomsearch/getCreditBookingByCustomerId?storeId={1}&custId={2}
*/   
    try{
      url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_REPORT_CREDIT_BOOKING_CUSTOMER_BY_ID).replace("{1}", String.valueOf(storeId))).replace("{2}", String.valueOf(custId));
      logger.debug("url in getCreditBookingByCustomerId Method In RoomSearch Service Class Is  ....{} ",url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      /*roombookingList=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
      for(RoomBooking roomBooking:roombookingList)
      {
      
        setPaidAmt(roomBooking);
       
      }
      
      responseString=gson.toJson(roombookingList, new TypeToken<List<RoomBooking>>() {}.getType());*/
      /*roombookingList=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
      for(RoomBooking roomBooking:roombookingList)
      {
        String bookingId=String.valueOf(roomBooking.getId());
        String res=getPaymentInfoByBookingId(bookingId);
        logger.debug("RESPONSE FOR ROOMBOOKING NETPAID AMOUNT CALCULATION IS:");
        logger.debug(res);
        
      }*/
      
      return responseString;
     }catch(Exception ex)
      {
      logger.debug("Exception",ex);
      return null;
    }
  }
  
  
  public String getPaymentInfoByBookingId(String bookingId) {
   /* URL FOR THIS IS
    http://192.168.1.34:8082/Restaurant/rest/roomsearch/getPaymentInfoByBookingId?bookingId=16
*/   
   
    try{
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_BASE_ROOM_GETPAYMENTINFO_BYBOOKINGID).replace("{1}", bookingId));
      logger.debug("url for getPaymentInfo() METHOD IN RoomSearchService.java CLASS....{}",url);
      ClientResponse response=WebServiceClient.callGet(url);
      String responseString=response.getEntity(String.class);
      logger.debug("payment info: {}", responseString);
      return responseString;
    }catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  }
  
 public RoomBooking setPaidAmt(RoomBooking roomBooking)
  {
    double paidAmount=0.00;
    String responseString=getPaymentInfoByBookingId(String.valueOf(roomBooking.getId()));
    logger.debug("PAYMENT INFO IN SETPAIDAMT METHOD IN ROOMSEARCHCONTROLLER CLASS IS : {}", responseString);
    List<Payment> paymentLst = gson.fromJson(responseString, new TypeToken<List<Payment>>() {}.getType());
    Iterator<Payment> iterator = paymentLst.iterator();
    while (iterator.hasNext()) {
      Payment payment = (Payment) iterator.next();
      paidAmount = paidAmount + payment.getPaidAmount();
    }
    logger.debug("NET PAID AMOUNT FOR ROOM BOOKING IN SETPAIDAMT METHOD IN ROOMSEARCHCONTROLLER CLASS IS : {} ",paidAmount);
    roomBooking.setPaidAmount(paidAmount);;
    return roomBooking;
  }
  
  
 public String addMoreRoom(RoomBooking RoomBooking)
 {
   /*URL FOR THIS IS:http://192.168.1.34:8082/Restaurant/rest/roomsearch/addMoreRoom
*/  
   
   try{
     String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOMBOOKING_ADD_MORE_ROOM);
     logger.debug("url in addMoreRoom method in RoomSearchService.java File....{}",url);
     ClientResponse response=WebServiceClient.callPost(url,gson.toJson(RoomBooking));
     String responseString=response.getEntity(String.class);
     logger.debug("response String in addMoreRoom method in RoomSearchService.java File {}", responseString);
     return responseString;
   }catch (Exception ex) {
     logger.debug("Exception",ex);
     return null;
   }
 }
 
 public String uploadCustImage(MultiPart multipart)
 {
   try{
     String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_UPLOAD_CUST_IMAGE);
     logger.debug("url....{}",url);
     //System.out.println("MULTIPART IS"+multipart.toString());
    // System.out.println("MULTIPART CONTENT DISPOSITION IS"+multipart.getContentDisposition());
     ClientResponse response=WebServiceClient.callPostData(url,multipart);
     
     String responseString=response.getEntity(String.class);
     logger.debug("response string...{}",responseString);
     //System.out.println("RESPONSE STRING IN SERVICE IS:"+responseString);
     return responseString;
   }
   catch(Exception ex)
   {
     logger.debug("Exception",ex);
     return null;  
   }
 }
 
 public String getCustImageById(Integer id) {
   try {
     System.out.println("getCustImageById() IS CALLED");
     String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
         + (CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GET_CUST_IMAGE_BY_ID)
             .replace("{1}", String.valueOf(id)));
     ClientResponse response = WebServiceClient.callGet(url);
     if(response.getStatus()==200){
       return url;
     }else{
       return "failure";
     }
   } catch (Exception e) {
     logger.error("Exception: ", e);
     return null;
   }
 }
 
 
  
  
}
