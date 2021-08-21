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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.controller.MenuMgntController;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.roombooking.adm.model.Room;
import com.sharobi.webpos.roombooking.adm.model.RoomInfo;
import com.sharobi.webpos.roombooking.adm.model.RoomType;
import com.sharobi.webpos.roombooking.adm.model.TaxForRoomBook;
import com.sharobi.webpos.roombooking.adm.service.HotelTaxMgntService;
import com.sharobi.webpos.roombooking.adm.service.RoomMgntService;
import com.sharobi.webpos.roombooking.adm.service.RoomTypeService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


@Controller
@RequestMapping("/roommgnt")
public class RoomController {
	
	private final static Logger logger=LogManager.getLogger(MenuMgntController.class);
	private final static RoomMgntService roomService=new RoomMgntService();
	//private final static AmenitiesService amenitiesService=new AmenitiesService();
	private final static RoomTypeService rmtypeService=new RoomTypeService();
	private final static HotelTaxMgntService hoteltaxmgntService=new HotelTaxMgntService();

	@RequestMapping(value="/loadroom",method=RequestMethod.GET)
	public ModelAndView loadRoomPage(Model model,HttpSession session)
	{
		logger.debug("in loadroom...! ");
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
		
		List<Room> roomList=roomService.getRoom(customer.getStoreId());
		session.setAttribute("roomList", roomList);
	//	mav.addObject("roomList",roomList);
		
		List<RoomType> roomtypeList=rmtypeService.getRoomTypeByStoreId(customer.getStoreId());
//		//List<TaxForRoomBook> hotelTaxList=hoteltaxmgntService.getAllTaxListByHotelId(customer.getStoreId());
//		//session.setAttribute("roomtypeList", roomtypeList);
		mav.addObject("roomtypeList",roomtypeList);
		mav.setViewName(ForwardConstants.VIEW_ROOM_MANAGEMENT_PAGE);
		return mav;
	}

	@RequestMapping(value="/getroomtype",method=RequestMethod.GET)
	public void getTaxDetails(HttpSession session,HttpServletResponse response) throws IOException
	{
		logger.debug("in loadroomTYPES...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			out.print(rmtypeService.getRoomTypeByStoreId(customer.getStoreId()));
			out.flush();
		}
	}
	@RequestMapping(value="/addroom",method=RequestMethod.POST)
	public void addRoom(@RequestBody String roomString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addroom......{}",roomString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			//response.setCharacterEsncoding("UTF-8");
			//request.setCharacterEncoding("UTF-8");
			//MenuCategory category=new MenuCategory();
			Gson gson = new GsonBuilder().create();
			RoomInfo room =gson.fromJson(roomString, new TypeToken<RoomInfo>() {
			}.getType());
	
			//room.setId(0);
			String res=roomService.addRoom(room);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/editroom",method=RequestMethod.POST)
	public void editRoom(@RequestBody String roomString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editroom......{}",roomString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			RoomInfo room =gson.fromJson(roomString, new TypeToken<RoomInfo>() {
			}.getType());
			//amenities.setFlag("Y");
			String res=roomService.editRoom(room);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/deleteroom",method=RequestMethod.POST)
	public void deleteRoom(@RequestBody String roomString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteroom......{}",roomString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			RoomInfo room =gson.fromJson(roomString, new TypeToken<RoomInfo>() {
			}.getType());
			String res=roomService.deleteRoom(room);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
}
