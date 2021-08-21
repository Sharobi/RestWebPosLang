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
import com.sharobi.webpos.adm.controller.MenuMgntController;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.roombooking.adm.model.Amenities;
import com.sharobi.webpos.roombooking.adm.model.AmenitiesInfo;
import com.sharobi.webpos.roombooking.adm.service.AmenitiesService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;




@Controller
@RequestMapping("/rmmgnt")
public class AmenitiesController {
	private final static Logger logger=LogManager.getLogger(MenuMgntController.class);
	private final static AmenitiesService amenitiesService=new AmenitiesService();
	
	@RequestMapping(value="/loadamenities",method=RequestMethod.GET)
	public ModelAndView loadAmenitiesPage(Model model,HttpSession session)
	{
		logger.debug("in loadamenities...! ");
		ModelAndView mav=new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);

			return mav;
		}
	
	//	List<MenuCategory> menusubcategoryList=menumgntService.getMenuSubCategoryByStoreId(customer.getStoreId());
	//	mav.addObject("catList",menuCatList);
		//mav.addObject("menucategory",menucategory);
		//model.addAttribute("printKotMaster", new PrintKotMaster());
	//	mav.addObject("menusubcategorylist",menusubcategoryList);
	//	mav.addObject(Constants.ADMIN,"Y");
		
		//Amenities rmamenities=null;
		List<AmenitiesInfo> amenitiesList=amenitiesService.getRoomAmenities(customer.getStoreId());
		//session.setAttribute("sesamenitiesList", amenitiesList);
		mav.addObject("amenitiesList",amenitiesList);
		mav.setViewName(ForwardConstants.VIEW_ROOM_AMENITIES_PAGE);
		return mav;
	}
	
	@RequestMapping(value="/addamenities",method=RequestMethod.POST)
	public void addRoomAmenities(@RequestBody String amenitiesString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In addmamenities......{}",amenitiesString);
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
			Amenities amenities =gson.fromJson(amenitiesString, new TypeToken<Amenities>() {
			}.getType());
			//category.setMenuCategoryName(catName);
			//category.setBgColor(bgColor);
			amenities.setFlag("Y");
			
			String res=amenitiesService.addAmenities(amenities);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}
	@RequestMapping(value="/editamenities",method=RequestMethod.POST)
	public void editAmenities(@RequestBody String amenitiesString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In editmenucategory......{}",amenitiesString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			Amenities amenities =gson.fromJson(amenitiesString, new TypeToken<Amenities>() {
			}.getType());
			//amenities.setFlag("Y");
			String res=amenitiesService.editAmenities(amenities);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}


	@RequestMapping(value="/deleteamenities",method=RequestMethod.POST)
	public void deleteAmenities(@RequestBody String amenitiesString,HttpSession session,HttpServletResponse response,HttpServletRequest request) throws IOException
	{
		logger.debug("In deleteMenuCategory......{}",amenitiesString);
		//ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))!=null)
		{
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new GsonBuilder().create();
			Amenities amenities =gson.fromJson(amenitiesString, new TypeToken<Amenities>() {
			}.getType());
			String res=amenitiesService.deleteAmenities(amenities);
			System.out.println("res:"+res);
			out.print(res);
			out.flush();
		}
	}

}
