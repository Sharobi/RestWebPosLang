/**
 * 
 */
package com.sharobi.webpos.adm.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestHeader;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.StoreCustomer;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author habib
 *
 */
@Service
public class StoreCustomerMgntService {

	private final static Logger logger=LogManager.getLogger(StoreCustomerMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<StoreCustomer> getStoreCustomerList(int storeId)
	{
		List<StoreCustomer> storeCustomerList=new ArrayList<StoreCustomer>();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_GETSTORECUSTOMER).replace("{1}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer list: {}", responseString);
			storeCustomerList=gson.fromJson(responseString, new TypeToken<List<StoreCustomer>>() {}.getType());
			logger.debug("StoreCustomer List fetched: {}", storeCustomerList);
			return storeCustomerList;
		}catch(Exception ex){
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String addStoreCustomer(StoreCustomer storeCustomer)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_ADDSTORECUSTOMER);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(storeCustomer));
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
	
	public String editStoreCustomer(StoreCustomer storeCustomer)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_EDITSTORECUSTOMER);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(storeCustomer));
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
	
	public String deleteStoreCustomer(int id,int storeId)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_STORECUSTMGNT_STORECUSTOMER_DELETESTORECUSTOMER).replace("{1}", String.valueOf(id)).replace("{2}", String.valueOf(storeId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("response string...{}",responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;	
		}
	}

	public StoreCustomer getAddedCustomerData(int storeId, String contactNo) {
		StoreCustomer storeCustomerData=new StoreCustomer();
		try{
			logger.debug("Input [store id]: {}",storeId);
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_CREDITSALE_ORDER_GETCREDITCUSTOMERBYCONTACTNO).replace("{1}", String.valueOf(storeId)).replace("{2}",contactNo);
			
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_HOTELCOUNTRYLINKUP).replace("{1}", String.valueOf(storeId)).replace("{2}",String.valueOf(countryLinkId));
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			logger.debug("Response string in get customer: {}", responseString);
			storeCustomerData=gson.fromJson(responseString, new TypeToken<StoreCustomer>() {}.getType());
			logger.debug("StoreCustomer fetched: {}", storeCustomerData);
			return storeCustomerData;
		}catch(Exception ex){
			logger.debug("Exception",ex);
			return null;
		}
	}

  public String addRoomCustomer(StoreCustomer storeCust) {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_BASE_ROOM_CUSTOMER_ADDSTORECUSTOMER);
      logger.debug("url....{}",url);
      ClientResponse response=WebServiceClient.callPost(url, gson.toJson(storeCust));
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
  
  
  public String convertToCreditCustomer( StoreCustomer storeCustomer,String storeId) throws Exception {
    String responseString =null;
    /*url= http://192.168.1.34:8082/Restaurant/rest/storeCustomer/convertToCreditCustomer?storeId=29&custId=848
*/   
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_CUSTOMER_CONVERT_TO_CREDIT_CUSTOMER)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(storeCustomer.getId())));
      ClientResponse response = WebServiceClient.callGet(url);
      responseString = response.getEntity(String.class);
      logger.debug("url in convertToCreditCustomer IN StoreCustomerMgntService CLASS...{}",url);
      logger.debug("response string in convertToCreditCustomer ...{}",responseString);
    
    } catch (Exception e) {
      logger.error("Exception: ", e);
      //return null;
    }
    return responseString;
  }
  
  
  
  public String convertToCreditBooking(RoomBooking roomBooking) throws IOException {
    try {
      /*http://192.168.1.34:8082/Restaurant/rest/roomsearch/convertToCreditBooking
*/     
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_CUSTOMER_CONVERT_TO_CREDIT_BOOKING);
      logger.debug("url forconvertToCreditBooking in StoreCustomerMgntService Is....{}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(roomBooking));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  
}
