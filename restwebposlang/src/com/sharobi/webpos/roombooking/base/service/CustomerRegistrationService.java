package com.sharobi.webpos.roombooking.base.service;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.roombooking.base.model.RoomBookingInfo;
import com.sharobi.webpos.roombooking.base.model.RoomBookingPayment;
import com.sharobi.webpos.roombooking.base.model.UniqueIdTypeMaster;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class CustomerRegistrationService {
	private final static Logger logger=LogManager.getLogger(MenuMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<RoomBooking> getReserveIdBySearch(String fromDate, int storeId)//getAllreserveIdbyDateHotelId
	{
		List<RoomBooking> reserveIdList=new ArrayList<RoomBooking>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLRESERVEIDBYHOTELID).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			reserveIdList=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched: {}", reserveIdList);
			return reserveIdList;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	public List<RoomBooking> getReserveIdByPeriod(String fromDate,String toDate,int storeId,String bookingNo)//getAllreserveIdbyDateHotelId
	{
		List<RoomBooking> reserveIdListByPeriod=new ArrayList<RoomBooking>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLRESERVEIDBYDATEPERIOD).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(toDate)).replace("{3}",String.valueOf(storeId)).replace("{4}",bookingNo);

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			reserveIdListByPeriod=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched: {}", reserveIdListByPeriod);
			return reserveIdListByPeriod;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	public List<RoomBooking> getReserveIdByCustIdByPeriod(String fromDate,String toDate,String custId,int storeId)
	{
		List<RoomBooking> reserveIdListByPeriod=new ArrayList<RoomBooking>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLRESERVEID_BYCUSTID_BYDATEPERIOD).replace("{1}",String.valueOf(fromDate)).replace("{2}",String.valueOf(toDate)).replace("{3}",String.valueOf(custId)).replace("{4}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			reserveIdListByPeriod=gson.fromJson(responseString, new TypeToken<List<RoomBooking>>() {}.getType());
			logger.debug("all room List fetched: {}", reserveIdListByPeriod);
			return reserveIdListByPeriod;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	public List<RoomBookingInfo> getReserveIdByReserveId(String resId,int storeId)
	{
		List<RoomBookingInfo> reserveIdDetails=new ArrayList<RoomBookingInfo>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETALLRESERVEID_BYRESID).replace("{1}",String.valueOf(resId)).replace("{2}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			reserveIdDetails=gson.fromJson(responseString, new TypeToken<List<RoomBookingInfo>>() {}.getType());
			logger.debug("all room List fetched: {}", reserveIdDetails);
			return reserveIdDetails;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	/*public String cancelResevedCustomer(String reserveId,int storeId)
	{
		//String cancelReserveIdStatus;
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_CANCELBOOKINGBYRESERVEID).replace("{1}",String.valueOf(reserveId)).replace("{2}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
		//	cancelReserveIdStatus=gson.fromJson(responseString, new TypeToken<List<RoomBookingInfo>>() {}.getType());
			logger.debug("all room List fetched: {}", responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}*/
	
	public String cancelResevedCustomer(RoomBooking obj)
  {
    //String cancelReserveIdStatus;
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_CANCELBOOKINGBYRESERVEID);
      System.out.println("url:"+url);
      DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
      String today = formatter.format(new Date());
      ClientResponse response=WebServiceClient.callPost(url,gson.toJson(obj));
      String responseString=response.getEntity(String.class);
    //  cancelReserveIdStatus=gson.fromJson(responseString, new TypeToken<List<RoomBookingInfo>>() {}.getType());
      logger.debug("IN cancelResevedCustomer SERVICE: {}", responseString);
      return responseString;
    }
    catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
    
  }
	 
	
	
	/*public String advPaymentforResevedCustomer(String reserveId,int storeId,String amount,String bookingId)
	{
		//String cancelReserveIdStatus;
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_ADVANCEMENTBYRESERVEID).replace("{1}",String.valueOf(reserveId)).replace("{2}",String.valueOf(storeId)).replace("{3}",String.valueOf(amount)).replace("{4}",String.valueOf(bookingId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
		//	cancelReserveIdStatus=gson.fromJson(responseString, new TypeToken<List<RoomBookingInfo>>() {}.getType());
			logger.debug("all room List fetched: {}", responseString);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}*/
	
	public String getCustomerDetailsByReserveId(String reserveId,int storeId)
	{

		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_GETCUSTOMERDETAILSBYRESERVEID).replace("{1}",String.valueOf(reserveId)).replace("{2}",String.valueOf(storeId));

			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			return responseString;
		}
		catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		
	}
	public String bookRoom(RoomBooking RoomBookingDetails)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOM_BOOKROOM_POST);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(RoomBookingDetails));
			//ClientResponse response = WebServiceClient.callPostDataWithInfo(url,rb);
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
//	public String bookRoomStore(IdentityFile file, MultiPart multipart)
//	{
//		try{
//			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_ROOM_BOOKROOM_POST);
//			logger.debug("url....{}",url);
//			//ClientResponse response=WebServiceClient.callPost(url,gson.toJson(RoomBookingDetails));gson.toJson(rb),
//			ClientResponse response = WebServiceClient.callPostDataWithInfo(url,
//					file,multipart);
//			String responseString=response.getEntity(String.class);
//			logger.debug("response String {}", responseString);
//			return responseString;
//		}catch (Exception ex) {
//			logger.debug("Exception",ex);
//			return null;
//		}
//	}
public String getCustContactsbyName(int storeId,String name,String fromDate,String toDate, String func){
		
		try{
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_GETCUSTOMERDETAILS_BYNAME).replace("{1}", String.valueOf(name)).replace("{2}", String.valueOf(storeId)).replace("{3}", String.valueOf(fromDate)).replace("{4}", String.valueOf(toDate)).replace("{5}", String.valueOf(func)));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer details info: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}

public String getCustDetbyPhno(int storeId,String phno,String fromDate,String toDate, String func){
	
	try{
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_GETCUSTOMERDETAILS_BYPHNO).replace("{1}", String.valueOf(phno)).replace("{2}", String.valueOf(storeId)).replace("{3}", String.valueOf(fromDate)).replace("{4}", String.valueOf(toDate)).replace("{5}", String.valueOf(func)));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get customer details info: {}", responseString);
		return responseString;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}

public String getResDetListbyResId(int storeId,String resId,String fromDate,String toDate){
	
	try{
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_GETRESERVEDETAILSLIST_BYRESID).replace("{1}", String.valueOf(resId)).replace("{2}", String.valueOf(storeId)).replace("{3}", String.valueOf(fromDate)).replace("{4}", String.valueOf(toDate)));
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
public String getRmCustContactsbyPhoneNo(String phno,int storeId) {
	try{
		String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+(CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_GETROOMCUSTOMERDETAILS_BYPHNO).replace("{1}", String.valueOf(phno))).replace("{2}", String.valueOf(storeId));
		logger.debug("url....{}",url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		logger.debug("Response string in get room customer details info: {}", responseString);
		return responseString;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
}
public List<UniqueIdTypeMaster> getAllUniqueIdType(int storeId) {
	List<UniqueIdTypeMaster> idTypeDetails=new ArrayList<UniqueIdTypeMaster>();
	try{
		String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_ROOMMGNT_CUSTOMER_GETCUSTOMERIDTYPES).replace("{1}",String.valueOf(storeId));
		//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
		System.out.println("url:"+url);
		ClientResponse response=WebServiceClient.callGet(url);
		String responseString=response.getEntity(String.class);
		idTypeDetails=gson.fromJson(responseString, new TypeToken<List<UniqueIdTypeMaster>>() {}.getType());
		logger.debug("all menu sub category List fetched: {}", idTypeDetails);
		return idTypeDetails;
	}catch(Exception ex)
	{
		logger.debug("Exception",ex);
		return null;
	}
	}


public String advPaymentforResevedCustomer(RoomBookingPayment payment) {
  try{
    logger.info("advance payment service");
    ClientResponse response=WebServiceClient.callPost(CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_ADVANCEMENTBYRESERVEID), gson.toJson(payment));
    String responseString=response.getEntity(String.class);
    logger.debug("Response string: {}", responseString);
    return responseString;
    }catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;
    }
  
}
public String getCustomerDetailsById(String customerId, int storeId) {
  try{
    String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_BASE_ROOM_GETCUSTOMER_BYID).replace("{1}", customerId).replace("{2}", String.valueOf(storeId)));
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

public String checkIn(RoomBooking roomBookingObj) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_BASE_ROOM_CHECKIN);
      logger.debug("url....{}",url);
      ClientResponse response=WebServiceClient.callPost(url,gson.toJson(roomBookingObj));
      String responseString=response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    }catch (Exception ex) {
      logger.debug("Exception",ex);
      return null;
    }
  }
public String getPaymentInfo(String bookingId) {
  try{
    String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_BASE_ROOM_GETPAYMENTINFO_BYBOOKINGID).replace("{1}", bookingId));
    logger.debug("url....{}",url);
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





}
