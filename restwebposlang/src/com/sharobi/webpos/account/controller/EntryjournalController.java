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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.account.model.AccountDTO;
import com.sharobi.webpos.account.model.AccountGroupDTO;
import com.sharobi.webpos.account.model.AccountTypeDTO;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.account.model.Journal;
import com.sharobi.webpos.account.model.JournalList;
import com.sharobi.webpos.account.model.ParaJournalTypeMaster;
import com.sharobi.webpos.account.model.ResponseObj;
import com.sharobi.webpos.account.service.AccGroupService;
import com.sharobi.webpos.account.service.AccJournalService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;


/**
 * @author SK A SIDDIK
 *
 *         Feb 20, 2018
 */

@Controller
@RequestMapping("/accntenty")
public class EntryjournalController {

	private final static Logger logger = LoggerFactory.getLogger(EntryjournalController.class);
	/*@Autowired
	RoleService roleService;
	@Autowired
	InvSetupService invsetupService ;*/
	@Autowired
	AccJournalService accJournalService;
	@Autowired
	AccGroupService accountgroupservice ;

	@Autowired
	StoreService storeService;
	//@Autowired
	// StoreMgntService storeService;
	Gson gson = new Gson();


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : load all journal
	 *  url = /loadaccntjrl
	 * @param jl
	 * @param session
	 * @return
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/loadaccntjrl", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loadAccntGrp(@ModelAttribute JournalList jl, HttpSession session) {
		logger.info("In loadaccntjrl journal entry......" + jl.toString());
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
		List<ParaJournalTypeMaster> entrytypelist = this.accJournalService.getEntrytype(commonResultSetMapper);
	    commonResultSetMapper.setQs(jl.getQs());
		List<Journal> journallist = this.accJournalService.getAlljournallist(commonResultSetMapper);
		Store store=storeService.getStoreById(customer.getStoreId());

		mav.addObject("entypelist", entrytypelist);



		mav.addObject("cur", store.getCurrency());
	 	mav.addObject("gsttext", store.getGstText());


		System.out.println("------"+jl.getQs());
		if (jl.getQs() != null) {
			mav.addObject("qs", jl.getQs());
			mav.addObject("journallist", journallist);
		} else {
			mav.addObject("journallist", null);
		}

		List<AccountGroupDTO> accountgrouplist = this.accountgroupservice.getAllAccGroup(commonResultSetMapper);
		List<AccountTypeDTO> allAccTypes = this.accountgroupservice.getAllAccType(commonResultSetMapper);

		mav.addObject("accountgrouplist", accountgrouplist);
		mav.addObject("allAccTypes", allAccTypes);
		mav.setViewName(ForwardConstants.VIEW_ACCONTJOURNAL_PAGE);
		return mav;
	}

	/*
	 * for search ledger
	 */

	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : search  ledger by name
	 *  url = /searchledger
	 * @param tagName
	 * @param session
	 * @param response
	 * @return
	 * @throws IOException
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/searchledger", method = RequestMethod.POST)
	public ResponseObj searchledger(@RequestParam String tagName, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In searchledger---------", tagName);




		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();
			commonResultSetMapper.setName(tagName.trim());
		//	commonResultSetMapper.setCompanyId(userInfo.getCompanyId());
			commonResultSetMapper.setStoreId(customer.getStoreId());
			//commonResultSetMapper.setLang(lang);

			List<AccountDTO> ledgerlist = this.accJournalService.searchledger(commonResultSetMapper);
			logger.info("searchaccount List :" + ledgerlist);

			PrintWriter out1 = response.getWriter();
			response.setContentType("application/json");

			out1.print(gson.toJson(ledgerlist));
		}
		return null;
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : add journal
	 *  url = /addjournal
	 * @param journal
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/addjournal", method = RequestMethod.POST)
	public void addjournal(@RequestBody String journal, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In addjournal......{}" + journal);


		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			JournalList journalList = gson.fromJson(journal, new TypeToken<JournalList>() {
			}.getType());
			//journalList.setCompanyId(userInfo.getCompanyId());
			journalList.setStoreId(customer.getStoreId());
			journalList.setCreatedBy(customer.getId());
			//journalList.setLang(lang);
			//journalList.setFinyrId(userInfo.getFinyrId());

			//journalList.setFinyrCode(userInfo.getFinyrCode());

			logger.info("journalList:" + journalList);

			String res = this.accJournalService.addjournal(journalList);

			logger.info("res:" + res);

			out.print(res);
			out.flush();
		}
	}



	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : for update journal
	 *  url = /updatejournal
	 * @param journal
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/updatejournal", method = RequestMethod.POST)
	public void updatejournal(@RequestBody String journal, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In updatejournal......{}" + journal);


		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			JournalList journalList = gson.fromJson(journal, new TypeToken<JournalList>() {
			}.getType());
			//journalList.setCompanyId(userInfo.getCompanyId());
			journalList.setStoreId(customer.getStoreId());
			journalList.setCreatedBy(customer.getId());
			//journalList.setLang(lang);
			//journalList.setFinyrId(userInfo.getFinyrId());

			//journalList.setFinyrCode(userInfo.getFinyrCode());

			String res = this.accJournalService.updatejournal(journalList);
			logger.info("res:" + res);

			out.print(res);
			out.flush();
		}
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> :   delete journal by id
	 *  url = /deletejournal/{id}
	 * @param id
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/deletejournal/{id}", method = RequestMethod.GET)
	public void deletejournal(@PathVariable("id") int id, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In deletejournal--------=", id);

		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();
			//commonResultSetMapper.setCompanyId(userInfo.getCompanyId());
			commonResultSetMapper.setStoreId(customer.getStoreId());
			commonResultSetMapper.setId(id);
			String res = this.accJournalService.deleteJournal(commonResultSetMapper);

			logger.info("res:" + res);
			out.print(res);
			out.flush();
		}
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : edit journal by id
	 *  url = /editjournal/{id}
	 * @param id
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/editjournal/{id}", method = RequestMethod.GET)
	public void editjourla(@PathVariable("id") int id, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In editjournal--------=", id);

		  Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			response.setContentType("text/plain");
			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();
			//commonResultSetMapper.setCompanyId(userInfo.getCompanyId());
			commonResultSetMapper.setStoreId(customer.getStoreId());
			commonResultSetMapper.setId(id);
			//commonResultSetMapper.setFinYrId(userInfo.getFinyrId());

			JournalList journalList = this.accJournalService.editjournalbyid(commonResultSetMapper);

			logger.info("editjournal List :" + journalList);
			PrintWriter out1 = response.getWriter();
			response.setContentType("application/json");

			out1.print(gson.toJson(journalList));

		}
	}


	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : print journal voucher
	 *  url = /paymentcashprintjv/{id}/type/{type}
	 * @param id
	 * @param type
	 * @param session
	 * @param response
	 * @return
	 * @throws IOException
	 * Jun 19, 2018
	 */
 @RequestMapping(value = "/paymentcashprintjv/{id}/type/{type}", method = RequestMethod.GET)
	public ModelAndView paymentcashprintjv(@PathVariable("id") int id,@PathVariable("type") String type ,  HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In paymentcashprintjv--------=", id);

		ModelAndView mav = new ModelAndView();

		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}



		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());

		commonResultSetMapper.setId(id);

		Store store=storeService.getStoreById(customer.getStoreId());
		JournalList journalList = this.accJournalService.editjournalbyid(commonResultSetMapper);
		mav.addObject("journal", journalList);
		mav.addObject("store",store);
		mav.addObject("cur", store.getCurrency());
	//	mav.addObject("curdes", userInfo.getCurrency_desc());

		if (type.equals("PAY")) {
			mav.setViewName(ForwardConstants.VIEW_JOURNAL_PAYMENT_PRINT);
		}
		if (type.equals("REC")) {
			mav.setViewName(ForwardConstants.VIEW_JOURNAL_RECEIPT_PRINT);
		}

		return mav;
	}
}
