package com.sharobi.webpos.roombooking.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.roombooking.adm.model.AmenitiesInfo;
import com.sharobi.webpos.roombooking.adm.model.RoomAmenitiesMapInfo;
import com.sharobi.webpos.roombooking.adm.model.RoomType;
import com.sharobi.webpos.roombooking.adm.service.AmenitiesService;
import com.sharobi.webpos.roombooking.adm.service.RoomTypeAmenitiesMgntService;
import com.sharobi.webpos.roombooking.adm.service.RoomTypeService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/*import com.sun.xml.internal.bind.api.TypeReference;*/



@Controller
@RequestMapping("/roomtypeamenitiesmgnt")
public class RoomTypeAmenitiesMapController {


	private final static Logger logger=LogManager.getLogger(CountrySetupController.class);
	private final static AmenitiesService amenitiesService=new AmenitiesService();
	private final static RoomTypeService roomtypeService=new RoomTypeService();
	private final static RoomTypeAmenitiesMgntService roomtypeMapService=new RoomTypeAmenitiesMgntService();
	
	@RequestMapping(value="/viewroomtypeamenitiesmgnt",method=RequestMethod.GET)
	public ModelAndView viewroomtypeamenitiesmgnt(Model model,HttpSession session)
	{
		logger.debug("In viewroomtypeamenitiesmgnt......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		store=(Store) session.getAttribute(Constants.LOGGED_IN_STORE);
		List<RoomType> roomtypeList=roomtypeService.getRoomTypeByStoreId(customer.getStoreId());
		mav.addObject("roomtypeList",roomtypeList);
		session.setAttribute("sesRoomTypeList", roomtypeList);
		mav.addObject(Constants.ADMIN,"Y");
		mav.setViewName(ForwardConstants.VIEW_ROOMTYPE_AMENITIES_LINKUP_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/getAllAmenities",method=RequestMethod.GET)
	public void getAllAmenities(HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In getAllAmenities......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new Gson();
			List<AmenitiesInfo> amenitiesList=amenitiesService.getRoomAmenities(customer.getStoreId());
			//session.setAttribute("sesamenitiesList", amenitiesList);
			//mav.addObject("amenitiesList",amenitiesList);
			String res=gson.toJson(amenitiesList);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/getAllAmenitiesMapToRoomType",method=RequestMethod.GET)
	public void getAllAmenitiesMapToRoomType(@RequestParam String roomType, HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In getAllAmenitiesMapToRoomType......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			
			Gson gson = new Gson();
			String res=roomtypeMapService.getRoomAmenitiesMapToRoomType(roomType, customer.getStoreId());

			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	@RequestMapping(value="/assignRoomTypeAmenitiesLinkPost/{roomType_id}/{amenities}/{enabled}",method=RequestMethod.GET)
	public void assignRoomTypeAmenitiesLinkPost(
			@PathVariable("roomType_id") String roomType_id,
			@PathVariable("amenities") String amenities,
			@PathVariable("enabled") String enabled,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In assignRoomTypeAmenitiesLink......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
	
			amenities = amenities.substring(0, amenities.length() - 1);
			amenities = amenities.substring(1);
			List<String> amenitiesList = Arrays.asList(amenities.split("\\,"));
			enabled = enabled.substring(0, enabled.length() - 1);
			enabled = enabled.substring(1);
			List<String> enabledList = Arrays.asList(enabled.split("\\,"));
			
			List<String> amenitiesListFinal = new ArrayList<String>();
			
			for(int i=0; i<amenitiesList.size();i++)
			{
				int valAmenities = Integer.parseInt(amenitiesList.get(i).substring(1, amenitiesList.get(i).length() - 1));
				amenitiesListFinal.add(String.valueOf(valAmenities));
			}		
			List<RoomAmenitiesMapInfo> roomAmenitiesMapInfoFinal = new ArrayList<RoomAmenitiesMapInfo>();
						 
			for(int i=0; i<amenitiesListFinal.size();i++)
			{
				RoomAmenitiesMapInfo roomAmenitiesMapInfo = new RoomAmenitiesMapInfo();	
				
				roomAmenitiesMapInfo.setAmenities_id(Integer.parseInt(amenitiesListFinal.get(i)));
				roomAmenitiesMapInfo.setIsEnable(Integer.parseInt(enabledList.get(i)));
				roomAmenitiesMapInfo.setHotel_id(String.valueOf(customer.getStoreId()));
				roomAmenitiesMapInfo.setRoomType_id(Integer.parseInt(roomType_id));
				
				roomAmenitiesMapInfoFinal.add(roomAmenitiesMapInfo);
			}
			
			String res=roomtypeMapService.assignAmenitiesRoomTypeMap(roomAmenitiesMapInfoFinal);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	
	
	@RequestMapping(value="/updateRoomTypeAmenitiesLink/{roomType_id}/{amenities}/{enabled}",method=RequestMethod.GET)
	public void updateRoomTypeAmenitiesLink(
			@PathVariable("roomType_id") String roomType_id,
			@PathVariable("amenities") String amenities,
			@PathVariable("enabled") String enabled,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addcountry......");
		Customer customer=null;
		Store store=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			amenities = amenities.substring(0, amenities.length() - 1);
			amenities = amenities.substring(1);
			List<String> amenitiesList = Arrays.asList(amenities.split("\\,"));
			enabled = enabled.substring(0, enabled.length() - 1);
			enabled = enabled.substring(1);
			List<String> enabledList = Arrays.asList(enabled.split("\\,"));
			
			List<String> amenitiesListFinal = new ArrayList<String>();
			
			for(int i=0; i<amenitiesList.size();i++)
			{
				int valAmenities = Integer.parseInt(amenitiesList.get(i).substring(1, amenitiesList.get(i).length() - 1));
				amenitiesListFinal.add(String.valueOf(valAmenities));
			}		
			List<RoomAmenitiesMapInfo> roomAmenitiesMapInfoFinal = new ArrayList<RoomAmenitiesMapInfo>();
						 
			for(int i=0; i<amenitiesListFinal.size();i++)
			{
				RoomAmenitiesMapInfo roomAmenitiesMapInfo = new RoomAmenitiesMapInfo();	
				
				roomAmenitiesMapInfo.setAmenities_id(Integer.parseInt(amenitiesListFinal.get(i)));
				roomAmenitiesMapInfo.setIsEnable(Integer.parseInt(enabledList.get(i)));
				roomAmenitiesMapInfo.setHotel_id(String.valueOf(customer.getStoreId()));
				roomAmenitiesMapInfo.setRoomType_id(Integer.parseInt(roomType_id));
				
				roomAmenitiesMapInfoFinal.add(roomAmenitiesMapInfo);
			}
			System.out.println(roomAmenitiesMapInfoFinal);
			
			String res=roomtypeMapService.updateAmenitiesRoomTypeMap(roomAmenitiesMapInfoFinal);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
}
