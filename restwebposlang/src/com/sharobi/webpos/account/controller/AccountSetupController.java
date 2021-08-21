/**
 *
 */
package com.sharobi.webpos.account.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.account.model.AccountDTO;
import com.sharobi.webpos.account.model.AccountGroupDTO;
import com.sharobi.webpos.account.model.AccountTypeDTO;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.account.model.ResponseObj;
import com.sharobi.webpos.account.service.AccGroupService;
import com.sharobi.webpos.account.service.AccSetupService;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.base.model.Store;
import com.sharobi.webpos.base.service.StoreService;
import com.sharobi.webpos.util.Constants;
import com.sharobi.webpos.util.ForwardConstants;

/**
 * @author SK A Siddik
 *
 *         Nov 7, 2017
 */


@Controller
@RequestMapping("/accntsetup")
public class AccountSetupController {
	private final static Logger logger = LoggerFactory.getLogger(AccountSetupController.class);



	/*@Autowired
	InvSetupService invsetupService;*/
	@Autowired
	AccGroupService accountgroupservice;
	@Autowired
	AccSetupService accSetupService;
	@Autowired
	StoreService storeService;
	Gson gson = new Gson();



	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : load all account list
	 *  url =/loadaccntsetup
	 * @param model
	 * @param session
	 * @return
	 * Jun 19, 2018
	 */
	@RequestMapping(value = "/loadaccntsetup", method = RequestMethod.GET)
	public ModelAndView loadloadaccntsetup(Model model, HttpSession session) {
		logger.info("In loadaccountsetup ......");
		ModelAndView mav = new ModelAndView();

		Customer customer=null;
		if((customer=(Customer) session.getAttribute(Constants.LOGGED_IN_USER))==null)
		{
			mav.setViewName(ForwardConstants.REDIRECT_LOGIN_PAGE);
			return mav;
		}

		CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

		commonResultSetMapper.setStoreId(customer.getStoreId());


		/*
		 * service loading start here
		 */

	/*	String countrylist = this.invsetupService.getAllCountryList(commonResultSetMapper);
		List<CountryMaster> countryMasters = gson.fromJson(countrylist, List.class);*/
		List<AccountGroupDTO> accountgrouplist = this.accountgroupservice.getAllAccGroup(commonResultSetMapper);


		List<AccountTypeDTO> allAccTypes = this.accountgroupservice.getAllAccType(commonResultSetMapper);

	//	commonResultSetMapper.setFinYrId(userInfo.getFinyrId());
		commonResultSetMapper.setAsOnDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		List<AccountDTO> accountMasterslist = this.accSetupService.getAllAccountSetup(commonResultSetMapper);

		Store store=storeService.getStoreById(customer.getStoreId());


	 	mav.addObject("cur", store.getCurrency());
		mav.addObject("gsttext", store.getGstText());

		mav.addObject("accountgrouplist", accountgrouplist);
	/*	mav.addObject("contrylist", countryMasters);*/
		mav.addObject("allAccTypes", allAccTypes);
		mav.addObject("accountlist", accountMasterslist);
		mav.setViewName(ForwardConstants.VIEW_ACCONTSETUP_PAGE);
		return mav;
	}





	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : add new account
	 *  url =/addaccountsetup
	 * @param accountsetup
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
	 @RequestMapping(value = "/addaccountsetup", method = RequestMethod.POST)
	public void addaccontsetup(@RequestBody String accountsetup, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In addaccontsetup......{}" + accountsetup);


		  Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			AccountDTO accountMaster = gson.fromJson(accountsetup, new TypeToken<AccountDTO>() {
			}.getType());

			accountMaster.setStoreId(customer.getStoreId());
			accountMaster.setCreatedBy(customer.getId());

			//accountMaster.setFinyrId(customer.getFinyrId());

			String res = this.accSetupService.addAccountSetup(accountMaster);

			logger.info("res:" + res);
			out.print(res);
			out.flush();
		}
	}




	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : update the account
	 *  url =/updateaccountsetup
	 * @param accountsetup
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
	 @RequestMapping(value = "/updateaccountsetup", method = RequestMethod.POST)
	public void updateaccountsetup(@RequestBody String accountsetup, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In updateaccountsetup......{}" + accountsetup);

		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");

			AccountDTO accountMaster = gson.fromJson(accountsetup, new TypeToken<AccountDTO>() {
			}.getType());

			accountMaster.setStoreId(customer.getStoreId());
			accountMaster.setCreatedBy(customer.getId());



			String res = this.accSetupService.updateAccountSetup(accountMaster);

			logger.info("res:" + res);
			out.print(res);
			out.flush();
		}
	}



	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : delete the account by id
	 *  url =/deleteaccount/{id}
	 * @param id
	 * @param session
	 * @param response
	 * @throws IOException
	 * Jun 19, 2018
	 */
 @RequestMapping(value = "/deleteaccount/{id}", method = RequestMethod.GET)
	public void deleteAcc(@PathVariable("id") int id, HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In deleteaccount......{}", id);

		 Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			PrintWriter out = response.getWriter();
			response.setContentType("text/plain");
			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

			commonResultSetMapper.setStoreId(customer.getStoreId());
			commonResultSetMapper.setId(id);
			String res = this.accSetupService.deleteAccount(commonResultSetMapper);

			logger.info("res:" + res);
			out.print(res);
			out.flush();
		}
	}

	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> :  get tha all account group name
	 *  url =/getaccontgroupname
	 * @param session
	 * @param response
	 * @return
	 * @throws IOException
	 * Jun 19, 2018
	 */
	 @RequestMapping(value = "/getaccontgroupname", method = RequestMethod.GET)
	public List<AccountGroupDTO> getAccontGroupName(HttpSession session, HttpServletResponse response)
			throws IOException {
		logger.info("In getAccontGroupName hit......{}");

	    Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

			CommonResultSetMapper commonResultSetMapper = new CommonResultSetMapper();

			commonResultSetMapper.setStoreId(customer.getStoreId());

			List<AccountGroupDTO> allAccTypes =this. accountgroupservice.getAllAccGroup(commonResultSetMapper);
			logger.info("getAllAccgroup List :" + allAccTypes);

			PrintWriter out1 = response.getWriter();
			response.setContentType("application/json");

			out1.print(gson.toJson(allAccTypes));

		}
		return null;
	}



	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> :  get area list  by zone id
	 *  url = /getareabyzone
	 * @param commonresultsetmapperObj
	 * @param session
	 * @param response
	 * @return
	 * @throws IOException
	 * Jun 19, 2018
	 */
	/*@RequestMapping(value = "/getareabyzone", method = RequestMethod.POST)
	public List<AreaDTO> getAreabyZone(@RequestBody String commonresultsetmapperObj, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.info("In getAreabyZone......{}", commonresultsetmapperObj);

		String lang = null;
		if ((lang = (String) session.getAttribute(Constant.SES_LOGGED_IN_LANG)) == null) {
			lang = Constant.DEFAULT_LANG;
		}
		LoginInfoByUserDTO userInfo = null;

		if ((userInfo = (LoginInfoByUserDTO) session.getAttribute(Constant.SES_LOGGED_IN_USER)) != null) {

			CommonResultSetMapper commonResultSetMapper = gson.fromJson(commonresultsetmapperObj,
					new TypeToken<CommonResultSetMapper>() {
					}.getType());
			commonResultSetMapper.setCompanyId(userInfo.getCompanyId());
			commonResultSetMapper.setStoreId(userInfo.getStoreId());
			commonResultSetMapper.setLang(lang);
			List<AreaDTO> arealist = this.invsetupService.getAllAreaList(commonResultSetMapper);

			logger.info("autocompleteitem List :" + arealist);
			PrintWriter out1 = response.getWriter();
			response.setContentType("application/json");

			out1.print(gson.toJson(arealist));

		}
		return null;
	}*/

	/**
	 * @author SK A SIDDIK
	 * <h5>Description</h5> : search the account
	 *  url = /searchaccount
	 * @param commonresultsetmapperObj
	 * @param session
	 * @param response
	 * @return
	 * @throws IOException
	 * Jun 19, 2018
	 */
	 @RequestMapping(value = "/searchaccount", method = RequestMethod.POST)
	public ResponseObj searchaccount(@RequestBody String commonresultsetmapperObj, HttpSession session,
			HttpServletResponse response) throws IOException {
		logger.info("In searchaccount......{},{},{}", commonresultsetmapperObj);

		  Customer customer;
		   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {
			CommonResultSetMapper commonResultSetMapper = gson.fromJson(commonresultsetmapperObj,
					new TypeToken<CommonResultSetMapper>() {
					}.getType());


			commonResultSetMapper.setStoreId(customer.getStoreId());


			ResponseObj responseObj = this.accSetupService.searchaccount(commonResultSetMapper);

			logger.info("searchaccount List :" + responseObj);

			PrintWriter out1 = response.getWriter();
			response.setContentType("application/json");

			out1.print(gson.toJson(responseObj));
		}
		return null;
	}


		@RequestMapping(value = "searchledgerusinggroup", method = RequestMethod.POST)
		public List<AccountDTO> searchledgerusinggroup(@RequestBody String commonresultsetmapperObj, HttpSession session,
				HttpServletResponse response) throws IOException {

			logger.info("In searchledgerusinggrou......{}", commonresultsetmapperObj);

			 Customer customer;
			   if ((customer = (Customer) session.getAttribute(Constants.LOGGED_IN_USER)) != null) {

				CommonResultSetMapper commonResultSetMapper = gson.fromJson(commonresultsetmapperObj,
						new TypeToken<CommonResultSetMapper>() {
						}.getType());
				//commonResultSetMapper.setCompanyId(userInfo.getCompanyId());
				commonResultSetMapper.setStoreId(customer.getStoreId());
				//commonResultSetMapper.setLang(lang);
				//commonResultSetMapper.setId(1);

				System.out.println(commonResultSetMapper.toString());
				List<AccountDTO> allvendorledgerlist = this.accSetupService.searchallvendelledger(commonResultSetMapper);

				logger.info("autocompleteitem List :" + allvendorledgerlist);
				PrintWriter out1 = response.getWriter();
				response.setContentType("application/json");

				out1.print(gson.toJson(allvendorledgerlist));

			}
			return null;
		}
}
