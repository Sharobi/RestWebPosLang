/**
 * 
 */
package com.sharobi.webpos.adm.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.adm.model.User;
import com.sharobi.webpos.adm.service.AdminService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.login.service.LoginService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author habib
 * 
 */
@Controller
@RequestMapping("/admin")
public class AdminController {
	private final static Logger logger = LogManager.getLogger(AdminController.class);
	@Autowired AdminService adminService;
	@Autowired LoginService loginService;

	@RequestMapping(value = "/loginadminmodule/{pass}",
					method = RequestMethod.GET)
	public void deleteSubMenuCategory(	@PathVariable("pass") String pass,
										HttpSession session,
										HttpServletResponse response) throws IOException {
		logger.debug("In loginadminmodule......{}", pass);
		//ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			User user = new User();
			user.setUserId(customer.getContactNo());
			user.setPassword(pass);
			user.setStoreId(customer.getStoreId());
			String res = adminService.dologinAdminModule(user);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}
	
/*	@RequestMapping(value = "/loginadminmodule",
			method = RequestMethod.POST)
public void deleteSubMenuCategory(@Valid @ModelAttribute("user1") User user1,
								BindingResult result,
								HttpSession session,
								HttpServletResponse response) throws IOException {
logger.debug("In loginadminmodule......{}", user1.getPassword());
//ModelAndView mav = new ModelAndView();
Customer customer = null;
if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
	PrintWriter out = response.getWriter();
	response.setContentType("text/plain");
	User userObj = new User();
	userObj.setUserId(customer.getContactNo());
	userObj.setPassword(user1.getPassword());
	userObj.setStoreId(customer.getStoreId());
	String res = adminService.dologinAdminModule(userObj);
	System.out.println("res:" + res);
	out.print(res);
	out.flush();
}
}*/

	@RequestMapping(value = "/openchangepassword",
					method = RequestMethod.GET)
	public ModelAndView openchangepassword(	Model model,
											HttpSession session) {
		logger.debug("In openchangepassword...");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_CHANGE_PASSWORD_PAGE);
		model.addAttribute("user", new User());
		mav.addObject(Constants.ADMIN,"Y");
		return mav;
	}

	@RequestMapping(value = "/dochangepassword",
					method = RequestMethod.POST)
	public ModelAndView dochangepassword(	@ModelAttribute("user") User user,
											HttpSession session) {
		logger.debug("In dochangepassword...,{}", user);
		System.out.println("user.getPassword()=" + user.getPassword());
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_CHANGE_PASSWORD_PAGE);
		String msg = "";
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			customer.setPassword(user.getPassword());
			customer.setNewPasword(user.getNewPassword());
			msg = adminService.changePasswordModule(customer);
		}
		mav.addObject("msg", msg);
		mav.addObject(Constants.ADMIN,"Y");
		return mav;
	}

	@RequestMapping(value = "/databasebackup",
					method = RequestMethod.GET)
	public ModelAndView databasebackup(	Model model,
										HttpSession session) {
		logger.debug("In databasebackup...");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_DATABASE_BACKUP_PAGE);
		model.addAttribute("user", new User());
		mav.addObject(Constants.ADMIN,"Y");
		return mav;
	}

	@RequestMapping(value = "/dodatabackup",
					method = RequestMethod.POST)
	public ModelAndView dodatabackup(	@ModelAttribute("user") User user,
										HttpSession session) {
		logger.debug("In dochangepassword...,{}", user);
		System.out.println("user.getPassword()=" + user.getPassword());
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_DATABASE_BACKUP_PAGE);
		String msg = "";

		Customer customer = new Customer();
		customer.setContactNo(user.getUserName());
		customer.setPassword(user.getPassword());
		Customer custFromServer = loginService.login(customer);

		Customer loggedcustomer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER);
		if ((loggedcustomer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			if (custFromServer.getId() != 0 && loggedcustomer.getContactNo().equalsIgnoreCase(user.getUserName())) {
				custFromServer.setContactNo(user.getUserName());
				custFromServer.setPassword(user.getPassword());
				msg = adminService.doBackUpModule(custFromServer);
			} else {
				msg = "invalidlogin";
			}
		}

		mav.addObject("msg", msg);
		mav.addObject(Constants.ADMIN,"Y");
		return mav;
	}
	
	@RequestMapping(value = "/loadcleanlogfile",method = RequestMethod.GET)
	public ModelAndView loadCleanLogfile(Model model,HttpSession session) {
		logger.debug("In loadcleanlogfile...");
		ModelAndView mav = new ModelAndView();
		mav.setViewName(ForwardConstants.VIEW_CLEAN_LOG_FILE_PAGE);
		mav.addObject(Constants.ADMIN,"Y");
		return mav;
		}
	@RequestMapping(value = "/cleanlogfile",
			method = RequestMethod.GET)
	public void cleanLogfile(HttpSession session,
									HttpServletResponse response) throws IOException {
	logger.debug("In cleanlogfile......");
	//ModelAndView mav = new ModelAndView();
	Customer customer = null;
	if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");
		String res = adminService.clearLogFile();
		String resServer = adminService.clearLogFileServer();
		logger.debug("In cleanlogfile......res:"+res);
		logger.debug("In cleanlogfile......resServer:"+resServer);
		out.print(resServer);
		out.flush();
	}
	}
}
