/**
 * 
 */
package com.sharobi.webpos.adm.service;

import java.io.File;
import java.net.URLEncoder;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.sharobi.webpos.adm.model.User;
import com.sharobi.webpos.base.model.Customer;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.TomcatLogCleaner;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;


/**
 * @author habib
 * 
 */
@Service
public class AdminService {
	private final static Logger logger = LogManager.getLogger(AdminService.class);
	private final static Gson gson = new Gson();

	public String dologinAdminModule(User user) {
		try {
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_MODULE_LOGIN);
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(user));
			String responseString = response.getEntity(String.class);
			logger.debug("response string...{}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String changePasswordModule(Customer customer) {
		try {
			logger.debug("customer....{}", customer);
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_MODULE_PROFILE_CHANGEPASSWORD);
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callPost(url, gson.toJson(customer));
			String responseString = response.getEntity(String.class);
			logger.debug("response string...{}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}

	public String doBackUpModule(Customer customer) {
		try {
			logger.debug("customer....{}", customer);
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_MODULE_DATA_BACKUP).replace("{1}", String.valueOf(customer.getStoreId())).replace("{2}", String.valueOf(customer.getContactNo())).replace("{3}", String.valueOf(customer.getPassword())));
			logger.debug("url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("response string...{}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
	
	public String clearLogFile() {
		String msg;
		try {
			
			String logfilepath = CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_LOGFILE_PATH);
			String noofdaysbefore = CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_CLEANLOGFILE_DAYSBEFORE);
			logger.debug("logfilepath and noofdaysbefore....{},{}", logfilepath,noofdaysbefore);
			TomcatLogCleaner tomcatLogCleaner = new TomcatLogCleaner(new File(logfilepath), 0,Integer.valueOf(noofdaysbefore));
		    tomcatLogCleaner.clean();
			msg="success";
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			msg="failure";
		}
		return msg;
	}
	
	public String clearLogFileServer() {
		try {
			String serverlogfilepath=CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_LOGFILE_PATH_SERVER);
			String noofdaysbefore = CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_CLEANLOGFILE_DAYSBEFORE);
			serverlogfilepath=URLEncoder.encode(serverlogfilepath, "UTF-8");
			String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + (CommonResource.getProperty(CommonResource.WEBSERVICE_ADMIN_LOGFILE_CLEAN_SERVER).replace("{1}",serverlogfilepath).replace("{2}",noofdaysbefore));
			logger.debug("clearLogFileServer url....{}", url);
			ClientResponse response = WebServiceClient.callGet(url);
			String responseString = response.getEntity(String.class);
			logger.debug("clearLogFileServer response string...{}", responseString);
			return responseString;
		} catch (Exception ex) {
			logger.debug("Exception", ex);
			return null;
		}
	}
}
