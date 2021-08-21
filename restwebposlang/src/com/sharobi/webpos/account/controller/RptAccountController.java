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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.sharobi.webpos.account.model.AccountDTO;
import com.sharobi.webpos.account.model.AccountGroupDTO;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.account.model.ResponseObj;
import com.sharobi.webpos.account.service.AccGroupService;
import com.sharobi.webpos.account.service.Chartofaccountservice;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author SK A SIDDIK * Mar 2, 2018
 */

@Controller
@RequestMapping("/accrpt")
public class RptAccountController {
	private final static Logger logger = LoggerFactory.getLogger(EntryjournalController.class);
	@Autowired
	AccGroupService accountgroupservice;
	@Autowired
	Chartofaccountservice chartofaccountservice;
	@Autowired
	StoreService storeService;
	Gson gson = new Gson();

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for ledger view url = /ledger_rep
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/ledger_rep", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loadrptledger(HttpSession session) {
		logger.info("In  loadrptledger  display report.....");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");


		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);
		mav.setViewName(ForwardConstants.RPT_LEDGER_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for daily_collection view url =
	 *         /daily_collection
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/daily_collection", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView daily_collection(HttpSession session) {
		logger.info("In  daily_collection  display report.....");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");

		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);

		mav.setViewName(ForwardConstants.RPT_DAILY_COLLECTION_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for daily_payment view url =
	 *         /daily_payment
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/daily_payment", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView daily_payment(HttpSession session) {
		logger.info("In  daily_payment  display report.....");
		ModelAndView mav = new ModelAndView();

		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());


		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");

		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);
		mav.setViewName(ForwardConstants.RPT_DAILY_PAYMENT_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for trial balance view url = /trial_rep
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/trial_rep", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loadrpttrial(HttpSession session) {
		logger.info("In  trial balance   display report.....");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");

	   //	commonResultSetMapper.setFinYrId(userInfo.getFinyrId());

		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);
		mav.setViewName(ForwardConstants.RPT_TRIAL_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for balance sheet view url = /balshet_rep
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/balshet_rep", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView balshet_rep(HttpSession session) {
		logger.info("In  balance sheet   display report.....");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");

		// commonResultSetMapper.setFinYrId(userInfo.getFinyrId());

		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);
		mav.setViewName(ForwardConstants.RPT_BALANCE_SHEET_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for account balance chacking url =
	 *         /account_blnc
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/account_blnc", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView account_blnc(HttpSession session) {
		logger.info("In  account_blnc   display report.....");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");

		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);
		mav.setViewName(ForwardConstants.RPT_ACCOUNT_BALANCE_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : for profit and loss statement url =
	 *         /profit_loss
	 * @param session
	 * @return Jun 19, 2018
	 */
	@RequestMapping(value = "/profit_loss", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView profit_and_loss(HttpSession session) {
		logger.info("In  profit_loss   display report.....");
		ModelAndView mav = new ModelAndView();
		Customer customer = null;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) == null) {
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}
		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		List<AccountGroupDTO> accountgrouplist = accountgroupservice.getAllAccGroup(commonResultSetMapper);
		commonResultSetMapper.setQs("0");

		Store store = storeService.getStoreById(customer.getStoreId());
		mav.addObject("cur", store.getCurrency());
		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("store", store);
		mav.setViewName(ForwardConstants.RPT_ACCOUNT_PROFITANDLOSS_VIEW);
		return mav;
	}

	/**
	 * @author SK A SIDDIK
	 *         <h5>Description</h5> : search the ledger report url =
	 *         /searchledgerinreport
	 * @param tagName
	 * @param groupCode
	 * @param session
	 * @param response
	 * @return
	 * @throws IOException
	 *             Jun 19, 2018
	 */
	@RequestMapping(value = "/searchledgerinreport", method = RequestMethod.POST)
	public ResponseObj searchledger(@RequestParam String tagName, @RequestParam int groupCode, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.info("In searchledgerinreport---------", tagName, groupCode);

		Customer customer;
		if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();
			commonResultSetMapper.setName(tagName.trim());
			commonResultSetMapper.setId(groupCode);

			commonResultSetMapper.setStoreId(customer.getStoreId());

			logger.info("searchledgerinreport input string :" + commonResultSetMapper.toString());

			List<AccountDTO> ledgerlist = this.chartofaccountservice.searchledgerinreport(commonResultSetMapper);
			logger.info("searchledgerinreport List :" + ledgerlist);

			PrintWriter out1 = response.getWriter();
			response.setContentType("application/json");

			out1.print(gson.toJson(ledgerlist));
		}
		return null;
	}

}
