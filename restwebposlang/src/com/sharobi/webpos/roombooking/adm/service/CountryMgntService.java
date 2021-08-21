package com.sharobi.webpos.roombooking.adm.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.roombooking.adm.model.Country;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

public class CountryMgntService {
	private final static Logger logger=LogManager.getLogger(HotelTaxMgntService.class);
	private final static Gson gson=new Gson();
	
	public List<Country> getAllCountryList()
	{
		List<Country> countryList=new ArrayList<Country>();
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_GETALLCOUNTRIES);
			ClientResponse response=WebServiceClient.callGet(url);
			logger.debug(response);
			String responseString=response.getEntity(String.class);
			countryList=gson.fromJson(responseString, new TypeToken<List<Country>>() {}.getType());
			logger.debug("all country List fetched: {}", countryList);
			return countryList;
		}catch(Exception ex)
		{
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String updateCountryLink(int storeId, int countryLinkId)
	{
		try{
			
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_HOTELCOUNTRYLINKUP).replace("{1}", String.valueOf(storeId)).replace("{2}",String.valueOf(countryLinkId));
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callGet(url);
			String responseString=response.getEntity(String.class);			
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String addCountry(Country countrySetup)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_ADDCOUNTRY_POST);
			logger.debug("url....{}",gson.toJson(countrySetup));
			ClientResponse response=WebServiceClient.callPost(url,gson.toJson(countrySetup));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String editCountry(Country countryEdit)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_EDITCOUNTRY_POST);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(countryEdit));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
	
	public String deleteCountry(Country countryDelete)
	{
		try{
			String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_COUNTRY_DELETECOUNTRY_POST);
			logger.debug("url....{}",url);
			ClientResponse response=WebServiceClient.callPost(url, gson.toJson(countryDelete));
			String responseString=response.getEntity(String.class);
			logger.debug("response String {}", responseString);
			return responseString;
		}catch (Exception ex) {
			logger.debug("Exception",ex);
			return null;
		}
	}
}
