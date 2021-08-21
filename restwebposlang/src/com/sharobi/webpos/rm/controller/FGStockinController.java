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
import com.sharobi.webpos.rm.model.EstimateDailyProd;
import com.sharobi.webpos.rm.model.FgStockIn;
import com.sharobi.webpos.rm.service.FGStockinService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/fgstockin")
public class FGStockinController {
	private final static Logger logger = LogManager.getLogger(FGStockinController.class);
	@Autowired FGStockinService fgStockinService;
	@Autowired MenuMgntService menumgntService;

	@RequestMapping(value = "/loadfgstockin",
					method = RequestMethod.GET)
	public ModelAndView loadRecipeIngredients(	Model model,
												HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Date currDate = new Date();
			mav.addObject("today", currDate);
			List<EstimateDailyProd> edpList = fgStockinService.getFgStockinByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			mav.addObject("edpList", edpList);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGSTOCKIN_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getfgstockinbydateandstoreid",
					method = RequestMethod.POST)
	public ModelAndView getrequisitionbydateandstoreid(	@ModelAttribute("estimateDailyProd") EstimateDailyProd estimateDailyProd,
														Model model,
														HttpSession session) {
		System.out.println("estimateDailyProd.getDate()=" + estimateDailyProd.getDate());
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(estimateDailyProd.getDate());
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			List<EstimateDailyProd> edpList = fgStockinService.getFgStockinByDate(customer.getStoreId(), estimateDailyProd.getDate());
			mav.addObject("edpList", edpList);
			mav.addObject("today", date);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGSTOCKIN_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/createnewfgstockin",
					method = RequestMethod.POST)
	public void createNewFgStockin(	@RequestBody String fgstockin,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("in createnewfgstockin...{}", fgstockin);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			Date currDate = new Date();
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			FgStockIn fgStockIn2 = gson.fromJson(fgstockin, new TypeToken<FgStockIn>() {}.getType());
			fgStockIn2.setDate(currDate);
			String s=fgStockinService.createFGStockin(fgStockIn2);
			out.print(s);
			out.flush();
		}
	}

	@RequestMapping(value = "/approvedFGStockin",
					method = RequestMethod.GET)
	public ModelAndView approvedPO(	@RequestParam String storeId,
									@RequestParam String fgstockinid,
									@RequestParam String approveBy,
									Model model,
									HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) throws IOException {
		logger.debug("In approvedFGStockin......{},{},{}", storeId, fgstockinid, approveBy);
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			ModelAndView mav = new ModelAndView(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		PrintWriter out = response.getWriter();
		response.setContentType("application/json");
		fgStockinService.approveFgStockin(storeId, fgstockinid, approveBy);
		out.print("success");
		out.flush();
		return null;
	}
}
