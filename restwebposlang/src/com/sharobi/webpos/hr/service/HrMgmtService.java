/**
 * 
 */
package com.sharobi.webpos.hr.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
//import com.sharobi.webpos.adm.model.DesignationCategory;
import com.sharobi.webpos.adm.model.MenuCategory;
import com.sharobi.webpos.adm.service.MenuMgntService;
import com.sharobi.webpos.hr.model.Department;
import com.sharobi.webpos.hr.model.Designation;
import com.sharobi.webpos.hr.model.DutyShift;
import com.sharobi.webpos.hr.model.EmpAttendance;
import com.sharobi.webpos.hr.model.EmpLeaveCal;
import com.sharobi.webpos.hr.model.EmpShiftSchedule;
import com.sharobi.webpos.hr.model.EmpShiftScheduleList;
import com.sharobi.webpos.hr.model.Employee;
import com.sharobi.webpos.hr.model.EmployeeLeave;
import com.sharobi.webpos.hr.model.EmployeeType;
import com.sharobi.webpos.util.CommonResource;
import com.sharobi.webpos.util.WebServiceClient;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.multipart.MultiPart;

/**
 * @author sumon
 *
 */
@Service
public class HrMgmtService {
  private final Logger logger = LogManager.getLogger(MenuMgntService.class);
  private final Gson gson = new Gson();

  public List<Department> getAllDepartmentsByStoreId(int storeId) {
    try {
      List<Department> departmentList = new ArrayList<Department>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_DEPARTMENT).replace("{1}", String.valueOf(storeId));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      departmentList = gson.fromJson(responseString, new TypeToken<List<Department>>() {
      }.getType());
      return departmentList;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }

  public List<Designation> getAllDesignationByStoreId(int storeId) {
    try {
      List<Designation> designationList = new ArrayList<Designation>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_DESIGNATION).replace("{1}", String.valueOf(storeId));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      designationList = gson.fromJson(responseString, new TypeToken<List<Designation>>() {
      }.getType());
      return designationList;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }

  public List<DutyShift> getAllDutyShiftByStoreId(int storeId) {
    try {
      List<DutyShift> dutyShiftList = new ArrayList<DutyShift>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_DUTY_SHIFT).replace("{1}", String.valueOf(storeId));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);

      dutyShiftList = gson.fromJson(responseString, new TypeToken<List<DutyShift>>() {
      }.getType());
      return dutyShiftList;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }

  public DutyShift getDutyShiftsById(Integer storeId, Integer id) {
    try {
      DutyShift dutyShift = new DutyShift();
     // String temp1=CommonResource .getProperty(CommonResource.WEBSERVICE_HR_GET_DUTY_SHIFT);
     // String[]temp2=temp1.split("?");
      //String[]temp3=temp2[1].split("&");
     // temp3[0]="storeId="+storeId;
     // temp3[1]="id="+id;
     // String url=temp2[0]+temp3[0]+"&"+temp3[1];
      /*temp2[0]="storeId="+String.valueOf(storeId));
      temp1.replace("id={2}", "id="+String.valueOf(id));*/
      
      //System.out.println("URL IS:"+url);
     // System.out.println("TEMP1 IS "+temp1);
     
     /* String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_DUTY_SHIFT.replace("{1}", String.valueOf(storeId)))+ CommonResource
              .getProperty(CommonResource.WEBSERVICE_HR_GET_DUTY_SHIFT.replace("{2}", String.valueOf(id)));*/
     /* 
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_DUTY_SHIFT).replace("{1}", String.valueOf(storeId))+ CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_DUTY_SHIFT).replace("{2}", String.valueOf(id));*/
      
      
      
      
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_DUTY_SHIFT)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(id)));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);

      dutyShift = gson.fromJson(responseString, new TypeToken<DutyShift>() {
      }.getType());
      return dutyShift;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }

  public String editDesignation(Designation category) {
    // TODO Auto-generated method stub
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_UPDATE_DESIGNATION));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }

  public String deleteDesignation(Designation category) {
    try {
      System.out.println("Category: " + category);
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_INVENTORY_DELETE_DESIGNATION)
              .replace("{1}", String.valueOf(category.getId())).replace("{2}", String.valueOf(category.getStoreId())));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callGet(url);
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }

  public String addDesignation(Designation category) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HRMGNT_DESIGNATION_ADD_POST);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }

  public String addDepartment(Department category) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HRMGNT_DEPARTMENT_ADD_POST);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }

  public String editDepartment(Department category) {
    // TODO Auto-generated method stub
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_UPDATE_DEPARTMENT));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }

  public String deleteDepartment(Department category) {
    try {
      System.out.println("Category: " + category);
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_DELETE_DEPARTMENT)
              .replace("{1}", String.valueOf(category.getId())).replace("{2}", String.valueOf(category.getStoreId())));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callGet(url);
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  
  
  public String addDutyshift(DutyShift category) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HRMGNT_ADD_DUTY_SHIFT);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  public String editDutyshift(DutyShift category) {
    // TODO Auto-generated method stub
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_UPDATE_DUTY_SHIFT));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  
  
  public String deleteDutyshift(DutyShift category) {
    try {
      System.out.println("Category: " + category);
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_DELETE_DUTY_SHIFT)
              .replace("{1}", String.valueOf(category.getId())).replace("{2}", String.valueOf(category.getStoreId())));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callGet(url);
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  
  
  
  
  public List<EmployeeType> getAllEmployeeTypeByStoreId(int storeId) {
    try {
      List<EmployeeType> employeeTypeList = new ArrayList<EmployeeType>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_EMPLOYEE_TYPES).replace("{1}", String.valueOf(storeId));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);

      employeeTypeList = gson.fromJson(responseString, new TypeToken<List<EmployeeType>>() {
      }.getType());
      return employeeTypeList;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
  
 
  
  
  public String addEmployeetype(EmployeeType category) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HRMGNT_ADD_EMPLOYEE_TYPE);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  
  public String addEmployee(Employee employee) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HR_ADD_EMPLOYEE);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      //System.out.println("JSON EMPLOYEE OBJ IS:");
      //System.out.println(gson.toJson(employee));
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(employee));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  
  
  public EmployeeType getEmployeeTypesById(Integer storeId, Integer id) {
    try {
      EmployeeType employeetype = new EmployeeType();
      
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_EMPLOYEE_TYPE)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(id)));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);

      employeetype = gson.fromJson(responseString, new TypeToken<EmployeeType>() {
      }.getType());
      return employeetype;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
  
  
  public String editEmployeetype(EmployeeType category) {
    // TODO Auto-generated method stub
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_UPDATE_EMPLOYEE_TYPE));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(category));
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  
  public String updateEmployee(Employee employee) {
    // TODO Auto-generated method stub
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_UPDATE_EMPLOYEE));
      logger.debug("URL FOR EMPLOYEE UPDATE :: {}", url);
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(employee));
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  public String deleteEmployee(Employee employee) {
    try {
      //System.out.println("Employee: " + employee);
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_DELETE_EMPLOYEE)
              .replace("{1}", String.valueOf(employee.getId())).replace("{2}", String.valueOf(employee.getStoreId())));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callGet(url);
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  
  
  public String deleteEmployeetype(EmployeeType category) {
    try {
      System.out.println("Category: " + category);
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_DELETE_EMPLOYEE_TYPE)
              .replace("{1}", String.valueOf(category.getId())).replace("{2}", String.valueOf(category.getStoreId())));
      logger.debug("URL :: {}", url);
      ClientResponse response = WebServiceClient.callGet(url);
      logger.debug("JSON Response :: {}", response);
      String responseString = response.getEntity(String.class);
      logger.debug("Response String :: {}", responseString);
      return responseString;
    } catch (Exception e) {
      logger.error("Exception", e);
      return null;
    }
  }
  
  public String uploadImage(MultiPart multipart)
  {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HR_EMPLOYEE_IMAGE_UPLOAD);
      logger.debug("url....{}",url);
      //System.out.println("MULTIPART IS"+multipart.toString());
     // System.out.println("MULTIPART CONTENT DISPOSITION IS"+multipart.getContentDisposition());
      ClientResponse response=WebServiceClient.callPostData(url,multipart);
      
      String responseString=response.getEntity(String.class);
      logger.debug("response string...{}",responseString);
      //System.out.println("RESPONSE STRING IN SERVICE IS:"+responseString);
      return responseString;
    }
    catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;  
    }
  }
  
  
  public String uploadDocument(MultiPart multipart)
  {
    try{
      String url=CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)+CommonResource.getProperty(CommonResource.WEBSERVICE_HR_EMPLOYEE_DOCUMENT_UPLOAD);
      logger.debug("url....{}",url);
      ClientResponse response=WebServiceClient.callPostData(url,multipart);
      String responseString=response.getEntity(String.class);
      logger.debug("response string...{}",responseString);
      return responseString;
    }
    catch(Exception ex)
    {
      logger.debug("Exception",ex);
      return null;  
    }
  }
  
  public List<Employee> getAllEmployeesByStoreId(int storeId) {
    try {
      List<Employee> employeeList = new ArrayList<Employee>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_EMPLOYEES).replace("{1}", String.valueOf(storeId));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      logger.debug("url is:",url);
      logger.debug("response string...{}",responseString);
      employeeList = gson.fromJson(responseString, new TypeToken<List<Employee>>() {
      }.getType());
      return employeeList;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
  
  
  public Employee getEmployeeByStoreIdAndId(Integer storeId, Integer id) {
    try {
      Employee employee = new Employee();
      
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_EMPLOYEE_BY_ID)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(id)));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      logger.debug("response string in getemployee bystoreid and employeeid...{}",responseString);
      employee = gson.fromJson(responseString, new TypeToken<Employee>() {
      }.getType());
      return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
  
  public String getEmployeeImageById(Integer id) {
    try {
      Employee employee = new Employee();
      System.out.println("getEmployeeImageById() IS CALLED");
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_EMPLOYEEIMAGE_BY_ID)
              .replace("{1}", String.valueOf(id)));
      ClientResponse response = WebServiceClient.callGet(url);
      if(response.getStatus()==200){
        return url;
      }else{
        return null;
      }
      //logger.debug("response string in getemployeeimage by  employeeid...{}",responseString);
      //String responseString = response.getEntity(String.class);
      //logger.debug("response string in getemployeeimage by  employeeid...{}",responseString);
      /*employee = gson.fromJson(responseString, new TypeToken<Employee>() {
      }.getType());*/
      //return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
 
  
  public String getEmployeeDocImageById(Integer id) {
    try {
      Employee employee = new Employee();
      
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_EMPLOYEEDOCIMAGE_BY_ID)
              .replace("{1}", String.valueOf(id)));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      logger.debug("response string in getemployeedocimage by  employeeid...{}",responseString);
      if(response.getStatus()==200){
        return url;
      }else{
        return null;
      }
      /*employee = gson.fromJson(responseString, new TypeToken<Employee>() {
      }.getType());*/
      //return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
  
  
  public List<EmpShiftSchedule> getAllEmpShiftSchedule( String storeId,String fromDate,String toDate){
    List<EmpShiftSchedule> empshiftschedulelist = null;
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_EMPLOYEE_SHIFT_SCHEDULE)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(fromDate)).replace("{3}", String.valueOf(toDate)));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      logger.debug("url in getAllEmpShiftSchedule bystoreid and fromDate and toDate...{}",url);
      logger.debug("response string in getAllEmpShiftSchedule bystoreid and fromDate and toDate...{}",responseString);
      empshiftschedulelist = gson.fromJson(responseString, new TypeToken<List<EmpShiftSchedule>>() {
      }.getType());
     // return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      //return null;
    }
    return empshiftschedulelist;
  }
  
  
  
  public List<EmpShiftSchedule> getEmpShiftScheduleByStoreIdAndEmpIdAndDate( String storeId,String empId,String date){
    List<EmpShiftSchedule> empshiftschedulelist = new ArrayList<EmpShiftSchedule>();
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_EMPLOYEE_SHIFT_SCHEDULE_BY_ID_AND_DATE)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(empId)).replace("{3}", String.valueOf(date)));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      logger.debug("response string in getAllEmpShiftSchedule bystoreid and employeeid...{}",responseString);
      empshiftschedulelist = gson.fromJson(responseString, new TypeToken<List<EmpShiftSchedule>>() {
      }.getType());
     // return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      //return null;
    }
    return empshiftschedulelist;
  }
  
  public String addEmployeeShiftSchedule(EmpShiftScheduleList empShiftScheduleList) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HR_ADD_EMPLOYEE_SHIFT_SCHEDULE);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      //System.out.println("JSON EMPLOYEE OBJ IS:");
      //System.out.println(gson.toJson(employee));
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(empShiftScheduleList));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  
  public String updateEmployeeShiftSchedule(EmpShiftScheduleList empShiftScheduleList) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HR_UPDATE_EMPLOYEE_SHIFT_SCHEDULE);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      //System.out.println("JSON EMPLOYEE OBJ IS:");
      //System.out.println(gson.toJson(employee));
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(empShiftScheduleList));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  
  
  
  public String cancelEmployeeShiftSchedule(EmpShiftScheduleList empShiftScheduleList) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HR_CANCEL_EMPLOYEE_SHIFT_SCHEDULE);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      //System.out.println("JSON EMPLOYEE OBJ IS:");
      //System.out.println(gson.toJson(employee));
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(empShiftScheduleList));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
 
  public String addEmployeeAttendance(EmpAttendance employeeattendance) {
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + CommonResource.getProperty(CommonResource.WEBSERVICE_HR_ADD_EMPLOYEE_ATTENDANCE);
      // url=url.replaceAll(" ", "%20");
      logger.debug("url....{}", url);
      //System.out.println("JSON EMPLOYEE OBJ IS:");
      //System.out.println(gson.toJson(employee));
      ClientResponse response = WebServiceClient.callPost(url, gson.toJson(employeeattendance));
      String responseString = response.getEntity(String.class);
      logger.debug("response String {}", responseString);
      return responseString;
    } catch (Exception ex) {
      logger.debug("Exception", ex);
      return null;
    }
  }
  
  public String getAllEmployeeAttendance( String storeId,String fromDate,String toDate){
    //List<EmpAttendance> empattendancelist = null;
    String responseString =null;
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_EMPLOYEE_ATTENDANCE)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(fromDate)).replace("{3}", String.valueOf(toDate)));
      ClientResponse response = WebServiceClient.callGet(url);
      responseString = response.getEntity(String.class);
      logger.debug("url in getAllEmployeeAttendance bystoreid and fromDate and toDate...{}",url);
      logger.debug("response string in getAllEmployeeAttendance bystoreid and fromDate and toDate...{}",responseString);
      /*empattendancelist = gson.fromJson(responseString, new TypeToken<List<EmpAttendance>>() {
      }.getType());*/
     // return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      //return null;
    }
    return responseString;
  }
  public String getEmployeeAttendanceByStoreIdAndEmpIdAndDate( String storeId,String empId,String date){
    //List<EmpAttendance> empattendancelist =null;
    String responseString =null;
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_EMPLOYEE_ATTENDANCE_BY_ID_AND_DATE)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(empId)).replace("{3}", String.valueOf(date)));
      ClientResponse response = WebServiceClient.callGet(url);
       responseString = response.getEntity(String.class);
      logger.debug("response string in getEmpShiftSchedule bystoreid and employeeid and date...{}",responseString);
     /* empattendancelist = gson.fromJson(responseString, new TypeToken<List<EmpAttendance>>() {
      }.getType());*/
     // return employee;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      //return null;
    }
    return responseString;
  }
  
  public List<EmployeeLeave> getEmployeeLeaves(int storeId) {
    try {
      List<EmployeeLeave> employeeLeaveList = new ArrayList<EmployeeLeave>();
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT) + CommonResource
          .getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_EMPLOYEE_LEAVES).replace("{1}", String.valueOf(storeId));
      ClientResponse response = WebServiceClient.callGet(url);
      String responseString = response.getEntity(String.class);
      logger.debug("url in getEmployeeLeaves bystoreid ...{}",url);
      logger.debug("response string in getEmployeeLeaves bystoreid ...{}",responseString);
      employeeLeaveList = gson.fromJson(responseString, new TypeToken<List<EmployeeLeave>>() {
      }.getType());
      return employeeLeaveList;
    } catch (Exception e) {
      logger.error("Exception: ", e);
      return null;
    }
  }
  
  
  public String getEmployeeLeaveCalculationByStoreIdAndEmpIdAndFromDateAndToDate( String storeId,String empId,String fromDate,String toDate){
    String responseString =null;
    try {
      String url = CommonResource.getProperty(CommonResource.TARGET_WEBSERVICE_ENDPOINT)
          + (CommonResource.getProperty(CommonResource.WEBSERVICE_HR_GET_ALL_EMPLOYEE_LEAVES_CALCULATION_BY_YEAR)
              .replace("{1}", String.valueOf(storeId)).replace("{2}", String.valueOf(empId)).replace("{3}", String.valueOf(fromDate)).replace("{4}", String.valueOf(toDate)));
      ClientResponse response = WebServiceClient.callGet(url);
       responseString = response.getEntity(String.class);
      logger.debug("response string in getEmployeeLeaveCalculationByStoreIdAndEmpIdAndFromDateAndToDate bystoreid and employeeid and fromdate and todate...{}",responseString);
      /*empleavecallist = gson.fromJson(responseString, new TypeToken<List<EmpLeaveCal>>() {
      }.getType());
      return empleavecallist;*/
    } catch (Exception e) {
      logger.error("Exception: ", e);
      /*return null;*/
    }
    return responseString;
  }
  
}
