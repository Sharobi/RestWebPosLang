/**
 *
 */
package com.sharobi.webpos.account.controller;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.account.model.Chartofaccount;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.account.service.Chartofaccountservice;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author SK A SIDDIK
 *
 *         Mar 14, 2018
 */

@Controller
@RequestMapping("/chatacc")
public class ChartofaccountController {

	private final static Logger logger = LoggerFactory.getLogger(ChartofaccountController.class);

	@Autowired
	Chartofaccountservice chartofservice;
	@Autowired
	StoreService storeService;
	Gson gson = new Gson();


	@RequestMapping(value = "/chartofaccnt", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loadAccntGrp(@ModelAttribute Chartofaccount cofa, HttpSession session) {
		logger.info("In chartofaccnt  accall......" + cofa.toString());
		ModelAndView mav = new ModelAndView();

		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());


		commonResultSetMapper.setQs("0");


		commonResultSetMapper.setAccountID(0);
		commonResultSetMapper.setId(0);// as group id

		System.out.println(cofa.getAsOnDate());

		if (cofa.getAsOnDate()!=null) {
			commonResultSetMapper.setAsOnDate(cofa.getAsOnDate());
			mav.addObject("ason_Date", cofa.getAsOnDate());

		}else
		{
			cofa.setAsOnDate("0");
			mav.addObject("ason_Date", 0);

			commonResultSetMapper.setAsOnDate( new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		}
		List<Chartofaccount> chartofaccounts = this.chartofservice.getAllChartofaccount(commonResultSetMapper);
		Store store=storeService.getStoreById(customer.getStoreId());
    	//System.err.println(chartofaccounts.toString());


		mav.addObject("cur", store.getCurrency());
		mav.addObject("chartofaccounts", chartofaccounts);


		mav.setViewName(ForwardConstants.VIEW_CHARTOFACC_PAGE);
		return mav;
	}

}
