/**
 *
 */
package com.sharobi.webpos.account.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.account.model.AccountGroupDTO;
import com.sharobi.webpos.account.model.AccountTypeDTO;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.account.service.AccGroupService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 *
 * @autho  SK A SIDDIK
 * this is for account group controller
 *  @date   Feb 15, 2018
 */

@Controller
@RequestMapping("/accntgrp")
public class AccGroupController {
	private final static Logger logger = LoggerFactory.getLogger(AccGroupController.class);

	@Autowired
	AccGroupService accGroupService;

/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> :  load all account group as list
	 *  url = /loadaccntgrp
	 * @param model
	 * @param session
	 * @return
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/loadaccntgrp", method = RequestMethod.GET)
	public ModelAndView loadAccntGrp(Model model, HttpSession session) {
		logger.info("In accgroup setup......");
		ModelAndView mav = new ModelAndView();
		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();
		commonResultSetMapper.setStoreId(customer.getStoreId());
		List<AccountTypeDTO> allAccTypes = this.accGroupService.getAllAccType(commonResultSetMapper);
		mav.addObject("allAccTypes", allAccTypes);
		mav.setViewName(ForwardConstants.VIEW_LEDGER_PAGE);
		mav.addObject(Constants.ACCOUNT_MANAGEMENT,"Y");
		return mav;
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : search the account group
	 *  url = /searchaccntgrp
	 * @param commonResultSetMapper
	 * @param session
	 * @param response
	 * @return
	 * Jun 19, 2018
	 */


	@RequestMapping(value = "/searchaccntgrp", method = RequestMethod.POST)
	public ModelAndView searchAccntGrp(@ModelAttribute("commonResultSetMapper") CommonResultSetMapper commonResultSetMapper, HttpSession session,
			HttpServletResponse response) {
		logger.info("In searchaccntgrp......{},{},{}", commonResultSetMapper.toString());
		ModelAndView mav = new ModelAndView();

		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		System.out.println(commonResultSetMapper.getGroupName());

		commonResultSetMapper.setStoreId(customer.getStoreId());
		List<AccountGroupDTO> allAccGroups = this.accGroupService.getAllAccGroup(commonResultSetMapper);
		List<AccountTypeDTO> allAccTypes = this.accGroupService.getAllAccType(commonResultSetMapper);
		System.out.println("__allAccTypes__"+allAccGroups.toString());
		mav.addObject("allAccGroups", allAccGroups);
		mav.addObject("allAccTypes", allAccTypes);
		mav.addObject("groupName", commonResultSetMapper.getAccntGrpName());
		mav.setViewName(ForwardConstants.VIEW_LEDGER_PAGE);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : add a new group in account
	 *  url = /addaccgrp
	 * @param AccGroupMasterObj
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */


  @RequestMapping("/addaccgrp")
	public void addAccGroup(@RequestBody String AccGroupMasterObj, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In addAccGroup......{},{},{}", AccGroupMasterObj);

		    Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			AccountGroupDTO accGrpMaster = gson.fromJson(AccGroupMasterObj, new TypeToken<AccountGroupDTO>() {
			}.getType());


			accGrpMaster.setCreatedBy(customer.getId());
			accGrpMaster.setStoreId(customer.getStoreId());
			String res = this.accGroupService.addAccGroup(accGrpMaster);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : edit the group by id
	 *  url = /editaccgrp
	 * @param AccGroupMasterObj
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
  @RequestMapping(value = "/editaccgrp", method = RequestMethod.POST)
	public void editBrand(@RequestBody String AccGroupMasterObj, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In editaccgrp......{}", AccGroupMasterObj);
        Customer customer;
	   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {


			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			Gson gson = new Gson();
			AccountGroupDTO accGrpMaster = gson.fromJson(AccGroupMasterObj, new TypeToken<AccountGroupDTO>() {
			}.getType());


			accGrpMaster.setUpdatedBy(customer.getId());
			accGrpMaster.setStoreId(customer.getStoreId());
			System.out.println(accGrpMaster.toString());
			String res =this.accGroupService.editAccGroup(accGrpMaster);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : delete the group by id
	 *  url = /deleteaccgroup
	 * @param id
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
 @RequestMapping(value = "/deleteaccgroup/{id}", method = RequestMethod.GET)
	public void deleteAccGroup(@PathVariable("id") int id, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In deleteCat......{}", id);
		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");


			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();
			commonResultSetMapper.setStoreId(customer.getStoreId());
			commonResultSetMapper.setId(id);
			String res = this.accGroupService.deleteAccGroup(commonResultSetMapper);
			System.out.println("res:" + res);
			out.print(res);
			out.flush();
		}
	}

}