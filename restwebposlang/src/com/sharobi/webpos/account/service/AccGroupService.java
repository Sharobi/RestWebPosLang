/**
 *
 */
package com.sharobi.webpos.account.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.account.model.AccountGroupDTO;
import com.sharobi.webpos.account.model.AccountTypeDTO;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author Arunima Roy SK A SIDDIK
 *
 *         Nov 3, 2017
 */
 @Service
public class AccGroupService {

		private final static Logger logger = LoggerFactory.getLogger(AccGroupService.class);
		Gson gson = new Gson();



		public List<AccountGroupDTO> getAllAccGroup(CommonResultSetMapper commonResultSetMapper) {
			try {
				String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
						+ CommonResource.getProperty(CommonResource.WEBSERVICE_INV_GET_ALL_ACCGROUP);
				logger.info("url....{}", url);
				ClientResponse response = WebServiceClient.callPost(url, gson.toJson(commonResultSetMapper));
				String responseString = response.getEntity(String.class);
				logger.info("Response string in get all account group: {}", responseString);
				List<AccountGroupDTO> accountGrpMasterList = new ArrayList<AccountGroupDTO>();
				accountGrpMasterList = gson.fromJson(responseString, new TypeToken<List<AccountGroupDTO>>() {
				}.getType());
				System.out.println(accountGrpMasterList);
				return accountGrpMasterList;
			} catch (Exception ex) {
				logger.info("Exception", ex);
				return null;
			}

		}


		public List<AccountTypeDTO> getAllAccType(CommonResultSetMapper commonResultSetMapper) {
			try {
				String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
						+ CommonResource.getProperty(CommonResource.WEBSERVICE_INV_GET_ALL_ACCTYPE);
				logger.info("url....{}", url);
				ClientResponse response = WebServiceClient.callPost(url, gson.toJson(commonResultSetMapper));
				String responseString = response.getEntity(String.class);
				logger.info("Response string in get all brand: {}", responseString);
				List<AccountTypeDTO> accountTypeList = new ArrayList<AccountTypeDTO>();
				accountTypeList = gson.fromJson(responseString, new TypeToken<List<AccountTypeDTO>>() {
				}.getType());
				return accountTypeList;
			} catch (Exception ex) {
				logger.info("Exception", ex);
				return null;
			}

		}

		public String addAccGroup(AccountGroupDTO accGrpMaster) {
			try {
				String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
						+ CommonResource.getProperty(CommonResource.WEBSERVICE_ACC_ADD_GROUP);
				logger.info("url....{}", url);
				ClientResponse response = WebServiceClient.callPost(url, gson.toJson(accGrpMaster));
				String responseString = response.getEntity(String.class);
				logger.info("response string...{}", responseString);
				return responseString;
			} catch (Exception ex) {
				logger.info("Exception", ex);
				return null;
			}
		}

		public String editAccGroup(AccountGroupDTO accGrpMaster) {
			try {
				String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
						+ CommonResource.getProperty(CommonResource.WEBSERVICE_ACC_UPDATE_GROUP);
				logger.info("url....{}", url);
				ClientResponse response = WebServiceClient.callPost(url, gson.toJson(accGrpMaster));
				String responseString = response.getEntity(String.class);
				logger.info("response string...{}", responseString);
				return responseString;
			} catch (Exception ex) {
				logger.info("Exception", ex);
				return null;
			}
		}

		public String deleteAccGroup(CommonResultSetMapper commonResultSetMapper) {
			try {
				String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
						+ CommonResource.getProperty(CommonResource.WEBSERVICE_ACC_DELETE_ACCGROUP);
				logger.info("url....{}", url);
				ClientResponse response = WebServiceClient.callPost(url, gson.toJson(commonResultSetMapper));
				String responseString = response.getEntity(String.class);
				logger.info("Response string in delete Account Group: {}", responseString);
				return responseString;
			} catch (Exception ex) {
				logger.info("Exception", ex);
				return null;
			}

		}
}
