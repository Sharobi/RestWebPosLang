package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.InvType;
import com.sharobi.webpos.adm.service.InventoryMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.inv.model.MetricUnit;
import com.sharobi.webpos.rm.model.RawClose;
import com.sharobi.webpos.rm.model.RawCloseChild;
import com.sharobi.webpos.rm.service.RawCloseService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/rawclose")
public class RawCloseController {
	public final static Logger logger = LogManager.getLogger(RawCloseController.class);
	@Autowired RawCloseService rawCloseService ;
	@Autowired InventoryMgntService inventorymgntService;
	public static final Gson gson = new Gson();

	@RequestMapping(value = "/loadrawclose",
					method = RequestMethod.GET)
	public ModelAndView loadRawClose(	Model model,
										HttpServletRequest request,
										HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			modelAndView.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return modelAndView;
		} else {
			Date d = new Date();
			List<RawCloseChild> rawCloseChilds = rawCloseService.getRawCloseItemsByDate(String.valueOf(customer.getStoreId()), Utility.getFormatedDateShort(d));
			modelAndView.addObject("rawCloseChilds", rawCloseChilds);
			List<InvType> invtypeList = inventorymgntService.getInvTypeList(customer.getStoreId());
			modelAndView.addObject("invtypeList", invtypeList);
			List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
			modelAndView.addObject("metricUnitList", metricUnitList);
			modelAndView.addObject("today", d);
			modelAndView.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			modelAndView.setViewName(ForwardConstants.VIEW_RAWCLOSE_PAGE);
			return modelAndView;
		}
	}

	@RequestMapping(value = "/getrawclosedatabystoreidanddate",
					method = RequestMethod.POST)
	public ModelAndView getRawCloseDatabyStoreIdandDate(@ModelAttribute("rawCloseChild") RawCloseChild rawCloseChild,
														Model model,
														HttpSession session) {
		System.out.println("call");
		ModelAndView modelAndView = new ModelAndView();
		Customer customer = null;
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(rawCloseChild.getDate());
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			modelAndView.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return modelAndView;
		} else {
			List<RawCloseChild> rawCloseChilds = rawCloseService.getRawCloseItemsByDate(String.valueOf(customer.getStoreId()), rawCloseChild.getDate());
			modelAndView.addObject("rawCloseChilds", rawCloseChilds);
			modelAndView.addObject("today", date);
			List<InvType> invtypeList = inventorymgntService.getInvTypeList(customer.getStoreId());
			modelAndView.addObject("invtypeList", invtypeList);
			List<MetricUnit> metricUnitList = inventorymgntService.getInvItemUnitList();
			modelAndView.addObject("metricUnitList", metricUnitList);
			modelAndView.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			modelAndView.setViewName(ForwardConstants.VIEW_RAWCLOSE_PAGE);
			return modelAndView;
		}
	}

	@RequestMapping(value = "/createrawclose",
					method = RequestMethod.POST)
	public void createFgClose(	@RequestBody String rawClose,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in createrawclose...{}", rawClose);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			RawClose rawClose1 = gson.fromJson(rawClose, new TypeToken<RawClose>() {}.getType());
			String s = rawCloseService.createRawClose(rawClose1);
			out.print(s);
			out.flush();
		}
	}

	@RequestMapping(value = "/approvedrawclose",
					method = RequestMethod.GET)
	public ModelAndView approvedrawclose(@RequestParam String rawcloseid,
										@RequestParam String storeId,
										@RequestParam String approveBy,
										@RequestParam String updatedBy,
										@RequestParam String updatedDate,
										Model model,
										HttpSession session,
										HttpServletRequest request,
										HttpServletResponse response) throws IOException {
		logger.debug("In approvedrawclose......{},{},{},{},{}", rawcloseid, storeId, approveBy, updatedBy, updatedDate);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		String s=rawCloseService.approveRawClose(rawcloseid, storeId, approveBy, updatedBy, updatedDate);
		out.print(s);
		out.flush();
		return null;
	}
}
