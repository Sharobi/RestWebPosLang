package com.sharobi.webpos.roombooking.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.roombooking.adm.model.TaxForRoomBook;
import com.sharobi.webpos.roombooking.adm.model.TaxForRoomBookInfo;
import com.sharobi.webpos.roombooking.adm.service.HotelTaxMgntService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/hoteltaxmgnt")
public class HotelTaxSetupController {

	private final static Logger logger=LogManager.getLogger(HotelTaxSetupController.class);
	private final static HotelTaxMgntService hoteltaxmgntService=new HotelTaxMgntService();
	
	@RequestMapping(value="/viewhoteltaxmgnt",method=RequestMethod.GET)
	public ModelAndView loadTaxMgnt(Model model,HttpSession session)
	{
		logger.debug("In viewhoteltaxmgnt......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
//		if(store.getCountryId()==null)
//		{
//			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
//			return mav;
//		}
		List<TaxForRoomBook> hotelTaxList=hoteltaxmgntService.getAllTaxListByHotelId(customer.getStoreId(),store.getCountryId());
		session.setAttribute("seshoteltaxList", hotelTaxList);
		mav.addObject("hoteltaxlist",hotelTaxList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_HOTEL_TAX_MGNT_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/addhoteltax",method=RequestMethod.POST)
	public void addHoteltax(@RequestBody String hoteltaxString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addhoteltaxmgnt......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new Gson();
			TaxForRoomBookInfo taxSetup =gson.fromJson(hoteltaxString, new TypeToken<TaxForRoomBookInfo>() {}.getType());

			taxSetup.setHotelId(String.valueOf(customer.getStoreId()));
			store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
			taxSetup.setCountry(store.getCountryId());
			String res=hoteltaxmgntService.addHotelTax(taxSetup);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	

	@RequestMapping(value="/edithoteltax",method=RequestMethod.POST)
	public void editHoteltax(@RequestBody String hoteltaxString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In edithoteltaxmgnt......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new GsonBuilder().create();
			TaxForRoomBookInfo taxSetup =gson.fromJson(hoteltaxString, new TypeToken<TaxForRoomBookInfo>() {}.getType());

			taxSetup.setHotelId(String.valueOf(customer.getStoreId()));
			store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
			taxSetup.setCountry(store.getCountryId());
			String res=hoteltaxmgntService.editHotelTax(taxSetup);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	

	@RequestMapping(value="/deletehoteltax",method=RequestMethod.POST)
	public void deleteHoteltax(@RequestBody String hoteltaxString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deletehoteltaxmgnt......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new GsonBuilder().create();
			TaxForRoomBookInfo taxSetup =gson.fromJson(hoteltaxString, new TypeToken<TaxForRoomBookInfo>() {}.getType());
			
			taxSetup.setHotelId(String.valueOf(customer.getStoreId()));
			store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
			taxSetup.setCountry(store.getCountryId());
			String res=hoteltaxmgntService.deleteHotelTax(taxSetup);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
}
