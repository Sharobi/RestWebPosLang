package com.sharobi.webpos.util;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.service.StoreCustomerMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.base.service.OrderService;

@Controller
@RequestMapping("/smsintegration")

public class SendSMS {
	private final static Logger logger=LogManager.getLogger(SendSMS.class);
	@Autowired OrderService orderService;
	@Autowired StoreCustomerMgntService storecustomermgntService;
	
	private final static Gson gson=new Gson();
	
	@RequestMapping(value = "/sendsms/{orderno}/subtot/{subtot}",
			method = RequestMethod.GET)
	public void sendSMS(@PathVariable("orderno") String orderno,@PathVariable("subtot") String subtot,HttpSession session,HttpServletResponse response) throws ParseException, IOException
	{
		logger.debug("in sendsms for...{}{}", orderno,subtot);
		Customer customer;
		Order order;
		String urlresponse = "";
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			
			StoreSMSConfiguration storeSMSData = (StoreSMSConfiguration)session.getAttribute("smsData");
			Gson gson = new Gson();
			//String selLang = (String) session.getAttribute(Constants.SELECTED_LANG);			
			 order = orderService.getOrderById(NumberUtils.toInt(orderno));
			String demo = gson.toJson(order);
			System.out.println("demo:" + demo);
			 SimpleDateFormat newFormat = new SimpleDateFormat("MMM dd, yyyy hh:mm:ss a");
			 Date dt = newFormat.parse(order.getOrderDate());
			 SimpleDateFormat newFormat1 = new SimpleDateFormat("yyyy-MM-dd");
			 String orderdate = newFormat1.format(dt);
			 
			 String time1 = order.getOrderTime();
			 String[] splitingtime = time1.split("\\s+");
		      
			
			// String urlParameters = "{\"mobile_no\":\"9832631490\",\"bill_no\":\"12211221011212\",\"bill_amount\":\"100\",\"merchant_id\":\"7804\",\"email\":\"sanjay.einfo@gmail.com\",\"sub_id\":\"109\",\"date\":\"2018-01-12\",\"type\":\"sub\",\"time\":\"12:08:50\",\"name\":\"Manish Mirani\"}";
			    String mobile_no = order.getCustomerContact();
				String bill_no = orderno;
				String bill_amount = subtot;
				String merchant_id = "";
				String email = ""; 
				String type = "";
				String sub_id = "";
					
				merchant_id=storeSMSData.getMerchantId();
				email = storeSMSData.getEmail();
				type = storeSMSData.getType();
				sub_id = storeSMSData.getSubId();
				
				
				String date = orderdate;
				String time = splitingtime[1];
				String name = order.getCustomerName();
			 
			 
				//String urlParameters = "{\"mobile_no\":\""+mobile_no+"\",\"bill_no\":\""+bill_no+"\",\"bill_amount\":\""+bill_amount+"\",\"merchant_id\":\""+merchant_id+"\",\"email\":\""+email+"\",\"sub_id\":\""+sub_id+"\",\"date\":\""+date+"\",\"type\":\""+type+"\",\"time\":\""+time+"\",\"name\":\""+name+"\"}";
			 
			 SmsParameter parameter = new SmsParameter();
		     parameter.setMobile_no(mobile_no);
		     parameter.setBill_no(bill_no);
		     parameter.setBill_amount(bill_amount);
		     parameter.setMerchant_id(merchant_id);
		     parameter.setEmail(email);
		     parameter.setSub_id(sub_id);
		     parameter.setDate(date);
		     parameter.setType(type);
		     parameter.setTime(time);
		     parameter.setName(name);
		    
		    
		    
		
		     String urlParameters= gson.toJson(parameter);
		     System.out.println("urlparameter:"+urlParameters);
		     
		     try{
		    		String requestUrl="";
		    		requestUrl = storeSMSData.getRequestUrl();
		    		URL url = new URL(requestUrl);
		    		HttpURLConnection uc = (HttpURLConnection)url.openConnection();
		    		uc.setDoOutput( true );
		    		uc.setInstanceFollowRedirects( false );
		    		uc.setRequestMethod(storeSMSData.getRequestMethod());
		    		uc.setRequestProperty("Content-Type", storeSMSData.getContentType());
		    		uc.setRequestProperty("merchantid",storeSMSData.getMerchantIdHeader());
		    		
		    		
		    		//Sending raw json data in the request body

		    		DataOutputStream dataoutput = new DataOutputStream(uc.getOutputStream());
		    		dataoutput .write(urlParameters.getBytes("UTF-8"));
		    		dataoutput .flush();
		    			    		
		    		urlresponse = uc.getResponseMessage();	    		
		    	    System.out.println(uc.getResponseCode());
		    		System.out.println(uc.getResponseMessage());
		    		System.out.println(uc.getErrorStream());
		    		
		    		
		    		uc.disconnect();
		    		} catch (UnsupportedEncodingException e) {
		    			
		    			e.printStackTrace();
		    		} catch (MalformedURLException e) {
		    			
		    			e.printStackTrace();
		    		} catch (IOException e) {
		    			
		    			e.printStackTrace();
		    		}
		     
		    	}
		out.print(urlresponse);
		out.flush();
		
	}
	
}
