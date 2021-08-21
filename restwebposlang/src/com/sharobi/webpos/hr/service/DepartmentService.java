/**
 * 
 *//*
package com.sharobi.webpos.hr.service;

import java.util.ArrayList;
import java.util.List;

import javax.jws.WebService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.sharobi.webpos.base.model.Language;
import com.sharobi.webpos.hr.model.Department;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;

*//**
 * @author Sumon
 *
 *//*
@Service
public class DepartmentService {
    private final static Logger logger = LogManager.getLogger(DepartmentService.class);
    private final static Gson gson = new Gson();
  
    public List<Department> getAllDepartmentsByStoreId(int storeId) {
        try{
          List<Department> departmentList = new ArrayList<Department>();
          String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_DEPARTMENT).replace("{1}", String.valueOf(storeId));
          ClientResponse response=WebServiceClient.callGet(url);
          String responseString=response.getEntity(String.class);
          departmentList= gson.fromJson(responseString, new TypeToken<List<Department>>() {}.getType());
          return departmentList;
        }
        catch(Exception e){
          logger.error("Exception: ", e);
          return null;
        }
    }
}
*/