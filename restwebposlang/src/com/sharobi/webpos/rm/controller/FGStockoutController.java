package com.sharobi.webpos.rm.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

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
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.rm.model.FgSaleOut;
import com.sharobi.webpos.rm.model.FgSaleOutItemsChild;
import com.sharobi.webpos.rm.service.FGStockoutService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;
import com.sharobi.webpos.util.Utility;

@Controller
@RequestMapping("/fgstockout")
public class FGStockoutController {
	private final static Logger logger = LogManager.getLogger(FGStockinController.class);
	private final static FGStockoutService fgStockoutService = new FGStockoutService();
	private final static MenuMgntService menumgntService = new MenuMgntService();

	@RequestMapping(value = "/loadfgstockout",
					method = RequestMethod.GET)
	public ModelAndView loadFGStockout(	Model model,
										HttpSession session) {

		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			Date currDate = new Date();
			mav.addObject("today", currDate);
			List<FgSaleOutItemsChild> fgSaleoutItems = fgStockoutService.getFgStockoutByDate(customer.getStoreId(), Utility.getFormatedDateShort(currDate));
			mav.addObject("fgSaleoutItems", fgSaleoutItems);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGSTOCKOUT_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/getfgstockoutbydateandstoreid",
					method = RequestMethod.POST)
	public ModelAndView getfgstockoutbydateandstoreid(	@ModelAttribute("fgSaleOut") FgSaleOut fgSaleOut,
														Model model,
														HttpSession session) {
		System.out.println("fgSaleOut.getDate()=" + fgSaleOut.getDate());
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		String pattern = "yyyy-MM-dd";
		Date date = null;
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			date = format.parse(fgSaleOut.getDate());
			System.out.println(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		} else {
			List<FgSaleOutItemsChild> fgSaleoutItems = fgStockoutService.getFgStockoutByDate(customer.getStoreId(), fgSaleOut.getDate());
			mav.addObject("today", date);
			mav.addObject("fgSaleoutItems", fgSaleoutItems);
			List<MenuCategory> menucategoryList = menumgntService.getMenuCategoryByStoreId(customer.getStoreId());
			mav.addObject("menucategoryList", menucategoryList);
			mav.addObject(Constants.RECEIPE_BASED_INVENTORY,"Y");
			mav.setViewName(ForwardConstants.VIEW_FGSTOCKOUT_PAGE);
			return mav;
		}
	}

	@RequestMapping(value = "/createnewfgstockout",
					method = RequestMethod.POST)
	public void createNewFgStockOut(	@RequestBody String fgstockout,
									HttpSession session,
									HttpServletResponse response) throws IOException {
		logger.debug("in createNewFgStockOut...{}", fgstockout);
		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			FgSaleOut fgSaleOut = gson.fromJson(fgstockout, new TypeToken<FgSaleOut>() {}.getType());
//			fgStockIn2.setDate(currDate);
			String s = fgStockoutService.createFGStockOut(fgSaleOut);
			out.print(s);
			out.flush();
		}
	}
}
