package com.sharobi.webpos.roombooking.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.controller.MenuMgntController;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Order;
import com.sharobi.webpos.roombooking.adm.model.RoomServices;
import com.sharobi.webpos.roombooking.adm.service.RoomService_Service;
import com.sharobi.webpos.roombooking.base.model.RoomBooking;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

@Controller
@RequestMapping("/rmservicemgnt")

public class RoomServiceController {

	private final static Logger logger=LogManager.getLogger(MenuMgntController.class);
	private final static RoomService_Service roomService=new RoomService_Service();

	
	@RequestMapping(value="/loadroomservices",method=RequestMethod.GET)
	public ModelAndView loadRoomPage(Model model,HttpSession session)
	{
		logger.debug("in loadroomservices...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);

			return mav;
		}
	
	//	mav.addObject(Constants.ADMIN,"Y");
		
		//Amenities rmamenities=null;
		List<RoomServices> roomservicesList=roomService.getRoomService(customer.getStoreId());
		session.setAttribute("roomservicesList", roomservicesList);
	
		mav.setViewName(ForwardConstants.VIEW_ROOM_SERVICE_MANAGEMENT_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/addroomservices",method=RequestMethod.POST)
	public void addRoomServices(@RequestBody String roomserivicesString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In roomserivices......{}",roomserivicesString);
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			//response.setCharacterEncoding("UTF-8");
			//request.setCharacterEncoding("UTF-8");
			//MenuCategory category=new MenuCategory();
			Gson gson = new GsonBuilder().create();
			RoomServices roomservices =gson.fromJson(roomserivicesString, new TypeToken<RoomServices>() {
			}.getType());
			//category.setMenuCategoryName(catName);
			//category.setBgColor(bgColor);
			roomservices.setCreatedBy(customer.getId());
			roomservices.setCreatedDate(sdf.format(new Date()));
			String res=roomService.addRoomServices(roomservices);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/editroomservices",method=RequestMethod.POST)
	public void editRoomServices(@RequestBody String roomserivicesString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editroomservices......{}",roomserivicesString);
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			RoomServices roomservices =gson.fromJson(roomserivicesString, new TypeToken<RoomServices>() {
			}.getType());
			//amenities.setFlag("Y");
			roomservices.setUpdatedBy(customer.getId());
      roomservices.setUpdatedDate(sdf.format(new Date()));
			String res=roomService.editRoomServices(roomservices);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}


	@RequestMapping(value="/deleteroomservices",method=RequestMethod.POST)
	public void deleteRoomServices(@RequestBody String roomserivicesString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteroomservices......{}",roomserivicesString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			RoomServices roomservices =gson.fromJson(roomserivicesString, new TypeToken<RoomServices>() {
			}.getType());
			String res=roomService.deleteRoomServices(roomservices);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	
	
	@RequestMapping(value="/loadbillregister",method=RequestMethod.GET)
  public ModelAndView loadBillRegisterPage(Model model,HttpSession session)
  {
    logger.debug("in loadbillregister...! ");
    ModelAndView mav=new ModelAndView();
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
    {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);

      return mav;
    }
    List<RoomBooking> billRegister = roomService.getBills(getTodayDate(),getTodayDate(),customer.getStoreId()); 
    mav.addObject("billRegister", billRegister);
    mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_BILLREGISTER_PAGE);
    return mav;
  }
	
	
	@RequestMapping(value="/viewallpaidbillperiodwise",method=RequestMethod.POST)
  public ModelAndView getBills(Model model,HttpSession session,@ModelAttribute("roombooking") RoomBooking roombooking)
  {
    logger.debug("in viewallpaidbillperiodwise...! ");
    ModelAndView mav=new ModelAndView();
    Customer customer=null;
    if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
    {
      mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);

      return mav;
    }
  
    List<RoomBooking> billRegister =roomService.getBills(roombooking.getCheckInDate(),roombooking.getCheckoutDate(),customer.getStoreId()); 
    mav.addObject("billRegister", billRegister);
    mav.setViewName(ForwardConstants.VIEW_ROOM_BOOKING_BILLREGISTER_PAGE);
    return mav;
  }
  
	public String getTodayDate()
  {
    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
      Date date = new Date();
      System.out.println("date:"+df.format(date));
      return df.format(date);
  }
}
