package com.sharobi.webpos.roombooking.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.controller.MenuMgntController;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.roombooking.adm.model.RoomType;
import com.sharobi.webpos.roombooking.adm.model.RoomTypeInfo;
import com.sharobi.webpos.roombooking.adm.model.TaxForRoomBook;
import com.sharobi.webpos.roombooking.adm.service.HotelTaxMgntService;
import com.sharobi.webpos.roombooking.adm.service.RoomTypeService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/rmtypemgnt")
public class RoomTypeController {
	
	
	
	private final static Logger logger=LogManager.getLogger(MenuMgntController.class);
	private final static RoomTypeService rmtypeService=new RoomTypeService();
	private final static HotelTaxMgntService hoteltaxmgntService=new HotelTaxMgntService();
	//private final static MenuService menuService = new MenuService();
	
	
	@RequestMapping(value="/loadroomtype",method=RequestMethod.GET)
	public ModelAndView loadRoomTypePage(Model model,HttpSession session)
	{
		logger.debug("in loadroomTYPES...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		Store store=null;

		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);

		List<TaxForRoomBook> hotelTaxAllList=hoteltaxmgntService.getAllTaxListByHotelId(customer.getStoreId(),store.getCountryId());
		mav.addObject("hoteltaxlist",hotelTaxAllList);
	
   
		List<String> taxNameList = new ArrayList<String>();
		   
	    for(int i=0;i<hotelTaxAllList.size();i++)
	    {
	     if(! taxNameList.contains(hotelTaxAllList.get(i).getName()))
	     {
	      taxNameList.add(hotelTaxAllList.get(i).getName());  
	     }    
	    }
	  System.out.println(taxNameList);
	session.setAttribute("seshoteltaxList", taxNameList);
		mav.addObject("hoteltaxlist",taxNameList);
		
		
		
		
		List<RoomType> roomtypeList=rmtypeService.getRoomTypeByStoreId(customer.getStoreId());
		//List<TaxForRoomBook> hotelTaxList=hoteltaxmgntService.getAllTaxListByHotelId(customer.getStoreId());
		mav.addObject("roomtypeList",roomtypeList);
		//mav.addObject("hotelTaxList",hotelTaxList);
		mav.setViewName(ForwardConstants.VIEW_ROOM_TYPES_PAGE);
		return mav;
	}

	@RequestMapping(value="/gettaxdetails/{taxname}",method=RequestMethod.GET)
	public void getTaxDetails(@PathVariable("taxname") String taxname,HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("In getsubcategorylistbycategory......{}",taxname);
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(hoteltaxmgntService.getAllTaxListByHotelIdbyName(customer.getStoreId(), taxname));
			out.flush();
		}
	}
	
	@RequestMapping(value="/addroomtype",method=RequestMethod.POST)
	public void addRoomType(@RequestBody String roomTypeString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addroomtype......{}",roomTypeString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new Gson();
			RoomTypeInfo roomType =gson.fromJson(roomTypeString, new TypeToken<RoomTypeInfo>() {}.getType());
			
			String res=rmtypeService.addRoomType(roomType);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}

	}
	
	@RequestMapping(value="/editroomtype",method=RequestMethod.POST)
	public void editRoomType(@RequestBody String roomTypeString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editroomtype......{}",roomTypeString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new Gson();
			RoomTypeInfo roomType =gson.fromJson(roomTypeString, new TypeToken<RoomTypeInfo>() {}.getType());
			
			String res=rmtypeService.editRoomType(roomType);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}

	}
	
	@RequestMapping(value="/deleteroomtype",method=RequestMethod.POST)
	public void deleteRoomType(@RequestBody String roomTypeString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteroomtype......{}",roomTypeString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new Gson();
			RoomTypeInfo roomType =gson.fromJson(roomTypeString, new TypeToken<RoomTypeInfo>() {}.getType());
			
			String res=rmtypeService.deleteRoomType(roomType);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}

	}
	
}


