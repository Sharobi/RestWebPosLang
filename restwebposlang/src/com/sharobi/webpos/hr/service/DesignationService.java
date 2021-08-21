/**
 * 
 *//*
package com.sharobi.webpos.hr.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.sharobi.webpos.hr.model.Designation;
import com.sharobi.webpos.util.CommonResource;

*//**
 * @author Sumon
 *
 *//*
@Service
public class DesignationService {
  private final static Logger logger = LogManager.getLogger(DepartmentService.class);
  private final static Gson gson = new Gson();

  public List<Designation> getAllDesignationByStoreId(int storeId) {
    try{
      List<Designation> designation = new ArrayList<>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HR_DESIGNATION).replace("{1}", String.valueOf(storeId));
      return designation;
    }catch(Exception e){
      return null;
    }
    

  }
}
*/