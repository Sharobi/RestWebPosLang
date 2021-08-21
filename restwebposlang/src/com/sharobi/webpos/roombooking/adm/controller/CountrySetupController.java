package com.sharobi.webpos.roombooking.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.math.NumberUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.roombooking.adm.model.Country;
import com.sharobi.webpos.roombooking.adm.service.CountryMgntService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/countrymgnt")
public class CountrySetupController {

	private final static Logger logger=LogManager.getLogger(CountrySetupController.class);
	private final static CountryMgntService countrymgntService=new CountryMgntService();
	
	@RequestMapping(value="/viewcountrymgnt",method=RequestMethod.GET)
	public ModelAndView loadCountryMgnt(Model model,HttpSession session)
	{
		logger.debug("In viewcountrymgnt......");
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
		List<Country> countryList=countrymgntService.getAllCountryList();
		session.setAttribute("sesCountryList", countryList);
		mav.addObject("countryList",countryList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_COUNTRY_SETUP_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/viewcountryhotelmgnt",method=RequestMethod.GET)
	public ModelAndView loadCountryHotelMgnt(Model model,HttpSession session)
	{
		logger.debug("In viewcountryhotelmgnt......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		List<Country> countryList=countrymgntService.getAllCountryList();
		session.setAttribute("sesCountryList", countryList);
		mav.addObject("countryList",countryList);
		mav.addObject(Constants.ADMIN,"Y");
		if(store.getCountryId()==0)
		{
			Country hotelCountry= new Country();
			hotelCountry.setId(0);
			hotelCountry.setCountryname(null);
			hotelCountry.setCourency(null);
			mav.addObject("hotelCountry",hotelCountry);
		}
		else
		{	
			for(int i=0;i<countryList.size();i++)
			{
				if(store.getCountryId()==countryList.get(i).getId())
				{
					mav.addObject("hotelCountry",countryList.get(i));
				}
			}	
		}
		mav.setViewName(ForwardConstants.VIEW_COUNTRY_HOTEL_LINKUP_PAGE);
		return mav;
	}
	
	@RequestMapping(value = "/updatecountrylink/{countryLinkId}",method = RequestMethod.GET)
	public void searchUnpaidOrderById(	@PathVariable("countryLinkId") String countryLinkId,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("in updatecountrylink...{}", countryLinkId);
		Customer customer;
		Store store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(countrymgntService.updateCountryLink(store.getId(), NumberUtils.toInt(countryLinkId)));
			out.flush();
		}
	}
	
	@RequestMapping(value="/addcountry",method=RequestMethod.POST)
	public void addCountry(@RequestBody String countryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addcountry......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new Gson();
			Country countrySetup =gson.fromJson(countryString, new TypeToken<Country>() {}.getType());

			String res=countrymgntService.addCountry(countrySetup);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	

	@RequestMapping(value="/editcountry",method=RequestMethod.POST)
	public void editCountry(@RequestBody String countryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editcountry......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new GsonBuilder().create();
			Country countryEdit =gson.fromJson(countryString, new TypeToken<Country>() {}.getType());

			String res=countrymgntService.editCountry(countryEdit);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	

	@RequestMapping(value="/deletecountry",method=RequestMethod.POST)
	public void deleteHoteltax(@RequestBody String countryString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteCountry......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			Gson gson = new GsonBuilder().create();
			Country countryDelete =gson.fromJson(countryString, new TypeToken<Country>() {}.getType());
			
			String res=countrymgntService.deleteCountry(countryDelete);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
}
