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
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.rm.model.FgClose;
import com.sharobi.webpos.rm.model.FgCloseChild;
import com.sharobi.webpos.rm.service.FGCloseService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/fgclose")
public class FGCloseController {
	private final static Logger logger = LogManager.getLogger(FGCloseController.class);
	@Autowired FGCloseService fgCloseService;
	@Autowired MenuMgntService menumgntService;

	@RequestMapping(value = "/loadfgclose",
					method = RequestMethod.GET)
	public ModelAndView loadFgClose(Model model,
									HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Date currDate = new Date();
			mav.addObject("today", currDate);
			List<FgCloseChild> fgCloseChildS = fgCloseService.getFgCloseByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			mav.addObject("fgCloseChildS", fgCloseChildS);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGCLOSE_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getfgclosebydateandstoreid",
					method = RequestMethod.POST)
	public ModelAndView getrequisitionbydateandstoreid(	@ModelAttribute("fgClose") FgClose fgClose,
														Model model,
														HttpSession session) {
		System.out.println("fgClose.getDate()=" + fgClose.getDate());
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(fgClose.getDate());
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			List<FgCloseChild> fgCloseChildS = fgCloseService.getFgCloseByDate(customer.getStoreId(), fgClose.getDate());
			mav.addObject("fgCloseChildS", fgCloseChildS);
			mav.addObject("today", date);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGCLOSE_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/createfgclose",
					method = RequestMethod.POST)
	public void createFgClose(	@RequestBody String fgClose,
								HttpSession session,
								HttpServletResponse response) throws IOException {
		logger.debug("in createfgclose...{}", fgClose);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			FgClose fgClose1 = gson.fromJson(fgClose, new TypeToken<FgClose>() {}.getType());
			String s = fgCloseService.createFGClose(fgClose1);
			out.print(s);
			out.flush();
		}
	}

	@RequestMapping(value = "/approvedfgclose",
					method = RequestMethod.GET)
	public ModelAndView approvedfgclose(	@RequestParam String storeId,
	                                    	@RequestParam String fgcloseid,
	                                    	@RequestParam String approveBy,
									@RequestParam String updatedBy,
									@RequestParam String updatedDate,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) throws IOException {
		logger.debug("In approvedfgclose......{},{},{},{},{}", storeId,fgcloseid,approveBy, updatedBy, updatedDate);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		fgCloseService.approveFgClose(storeId, fgcloseid, approveBy, updatedBy, updatedDate);
		out.print("success");
		out.flush();
		return null;
	}
}
