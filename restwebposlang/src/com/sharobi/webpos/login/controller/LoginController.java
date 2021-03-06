/**
 * 
 */
package com.sharobi.webpos.login.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.StoreDayBookRegister;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.login.model.KeyBean;
import com.sharobi.webpos.login.model.User;
import com.sharobi.webpos.login.service.LoginService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 * 
 */
@Controller
@RequestMapping("/authentication")
public class LoginController {
	private final static Logger logger = LogManager.getLogger(LoginController.class);
	@Autowired LoginService loginService;
	@Autowired StoreService storeService;

	@RequestMapping(value = "/login",
					method = RequestMethod.GET)
	public ModelAndView login(	Model model,
								HttpServletRequest request,
								HttpServletResponse response,
								HttpSession session) {
		logger.debug("In Login..." + request.getLocale().getDisplayLanguage());
		Locale locale = LocaleContextHolder.getLocale();
		logger.debug("In Login lang..." + locale);
		ModelAndView mav = new ModelAndView();

		Locale.setDefault(new Locale("en"));

		mav.setViewName(ForwardConstants.VIEW_LOGIN_PAGE);
		model.addAttribute("user", new User());
		return mav;
	}

	@RequestMapping(value = "/dologin",
					method = RequestMethod.POST)
	public ModelAndView doLogin(@Valid @ModelAttribute("user") User user,
								BindingResult result,
								HttpSession session) {
		logger.debug("In doLogin...");
		ModelAndView mav = new ModelAndView();
		//	Locale locale = LocaleContextHolder.getLocale();
		mav.setViewName(ForwardConstants.VIEW_LOGIN_PAGE);
		if (!result.hasErrors()) {
			Customer customer = new Customer();
			customer.setContactNo(user.getUserName());
			customer.setPassword(user.getPassword());
			Customer custFromServer = loginService.login(customer);

			if (custFromServer.getId() != 0) {

				System.out.println("custFromServer.getStatus()=" + custFromServer.getStatus());
				custFromServer.setPassword(null);
				session.setAttribute(Constants.LOGGED_IN_USER, custFromServer);
				session.setAttribute("count", 0); // for showing license expiry alert
				//Constants.ACTIVE_TOKEN= "hfgfhfhfhfghh13123";
				/*session.setAttribute(Constants.LANGUAGE, locale);*/
				//  session.setAttribute("language", locale);
				//mav.addObject("token", "");
				mav.setViewName(ForwardConstants.REDIRECT_HOME);
			} else {
				if (custFromServer.getMessage().equalsIgnoreCase("License Expired")) {
					result.reject("Failed.user.invalid.explicense");
					mav.addObject("msg", "explicense");
				} else if (custFromServer.getMessage().contains("You have no license!")) {
					result.reject("Failed.user.invalid.nolicense");
					mav.addObject("msg", "nolicense");
				} else
					result.reject("Failed.user.invalid");
			}
		}

		return mav;

	}

	@RequestMapping(value = "/logout",
					method = RequestMethod.GET)
	public ModelAndView logout(	Model model,
								HttpSession session) {
		logger.debug("in logout...");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			StoreDayBookRegister storeDayBookRegister = null;
			if ((storeDayBookRegister = (StoreDayBookRegister) session.getAttribute(Constants.REST_OPEN_DET)) == null) {

			} else {
				storeService.saveRestClosetime(customer.getStoreId(), customer.getId(), storeDayBookRegister.getId());
			}
		}
		if (session.getAttribute(Constants.LOGGED_IN_USER) != null) {
			session.removeAttribute(Constants.LOGGED_IN_USER);
			session.removeAttribute(Constants.LOGGED_IN_STORE);
			session.removeAttribute(Constants.ALL_UNPAIDORDER_LIST);
			session.removeAttribute(Constants.MENU_ALL_TREE);
			session.removeAttribute(Constants.LANG_LIST);
			session.removeAttribute(Constants.SELECTED_LANG);
			session.removeAttribute("posModuleObj");
			session.removeAttribute(Constants.REST_OPEN_DET);
			session.removeAttribute("dutyShiftList");
			session.removeAttribute("count");
		}
		mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
		model.addAttribute("user", new User());
		return mav;
	}

	@RequestMapping(value = "/addlicensekey/{lickey}",
					method = RequestMethod.GET)
	public ModelAndView addStoreLicenseInformation(	@PathVariable("lickey") String lickey,
													Model model,
													HttpSession session,
													HttpServletRequest request,
													HttpServletResponse response) throws IOException {
		logger.debug("In addlicensekey  Details......{},{}", lickey);
		KeyBean keyBean = loginService.addStoreLicenseInformation(lickey.trim());
		PrintWriter out;
		out = response.getWriter();
		response.setContentType("text/plain");
		out.print(new Gson().toJson(keyBean));
		out.flush();
		return null;
	}

}
