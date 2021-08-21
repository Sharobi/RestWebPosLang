package com.sharobi.webpos.roombooking.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.roombooking.adm.model.TaxForRoomBook;
import com.sharobi.webpos.roombooking.adm.model.TaxForRoomBookInfo;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class HotelTaxMgntService {
	private final static Logger logger=LogManager.getLogger(HotelTaxMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<TaxForRoomBook> getAllTaxListByHotelId(int storeId, int countryId)
	{
		List<TaxForRoomBook> hotelTaxList=new ArrayList<TaxForRoomBook>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_TAX_GETALLTAXES).replace("{1}",String.valueOf(storeId)).replace("{2}", String.valueOf(countryId));
			ClientResponse response=WebServiceClient.callGet(url);
			logger.debug(response);
			String responseString=response.getEntity(String.class);
			hotelTaxList=gson.fromJson(responseString, new TypeToken<List<TaxForRoomBook>>() {}.getType());
			logger.debug("all hotel tax List fetched: {}", hotelTaxList);
			return hotelTaxList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String addHotelTax(TaxForRoomBookInfo taxSetup)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_TAX_ADDTAX_POST);
			logger.debug("url....{}",gson.toJson(taxSetup));
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(taxSetup));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String editHotelTax(TaxForRoomBookInfo taxSetup)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_TAX_EDITTAX_POST);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(taxSetup));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String deleteHotelTax(TaxForRoomBookInfo taxSetup)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_TAX_DELETETAX_POST);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(taxSetup));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String getAllTaxListByHotelIdbyName(int storeId,String taxname)
	{
		
		
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HOTEL_TAX_GETALLTAXESBYHOTELID).replace("{1}",String.valueOf(storeId)).replace("{2}",String.valueOf(taxname));
			//String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_MENUMGNT_CATEROGY_GETCATEGORY).replace("{1}",String.valueOf(storeId));
			System.out.println("url:"+url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);
			
			logger.debug("all tax details List fetched: {}", responseString);
			return responseString;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
		

	}
	
}
