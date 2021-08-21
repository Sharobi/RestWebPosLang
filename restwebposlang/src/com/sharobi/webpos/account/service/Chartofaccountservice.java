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
import com.sharobi.webpos.account.model.AccountDTO;
import com.sharobi.webpos.account.model.Chartofaccount;
import com.sharobi.webpos.account.model.CommonResultSetMapper;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

/**
 * @author SK A SIDDIK
 *
 *         Mar 14, 2018
 */

@Service
public class Chartofaccountservice {
	private final static Logger logger = LoggerFactory.getLogger(Chartofaccountservice.class);
	Gson gson = new Gson();

	public List<Chartofaccount> getAllChartofaccount(CommonResultSetMapper commonResultSetMapper) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource.getProperty(CommonResource.WEBSERVICE_CHART_OF_ACCOUNT);
			logger.info("service getAllChartofaccount url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(commonResultSetMapper));
			String responseString = response.getEntity(String.class);
			logger.info("response string...{}", responseString);

			List<Chartofaccount> chartofaccount = new ArrayList<Chartofaccount>();
			chartofaccount = gson.fromJson(responseString, new TypeToken<List<Chartofaccount>>() {
			}.getType());
			//
			return chartofaccount;
		} catch (Exception ex) {
			logger.info("Exception", ex);
			return null;
		}
	}

	/*
	 * for searche ledger in report
	 */

	public List<AccountDTO> searchledgerinreport(CommonResultSetMapper commonResultSetMapper) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
					+ CommonResource.getProperty(CommonResource.WEBSERVICE_ACCOUNT_REPORT_SEARCH_BY_GROUP);
			logger.info("service searchledger url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(commonResultSetMapper));
			String responseString = response.getEntity(String.class);
			logger.info("response string...{}", responseString);

			List<AccountDTO> listAccountDTO = new ArrayList<AccountDTO>();
			listAccountDTO = gson.fromJson(responseString, new TypeToken<List<AccountDTO>>() {
			}.getType());
			//
			return listAccountDTO;

		} catch (Exception ex) {
			logger.info("Exception", ex);
			return null;
		}
	}

}
