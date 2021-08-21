/**
 * 
 *//*
package com.sharobi.webpos.hr.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.sharobi.webpos.hr.service.DepartmentService;
import com.sharobi.webpos.util.ForwardConstants;

*//**
 * @author sharobi13
 *
 *//*
@Controller
@RequestMapping("/department")
public class DepartmentController {
   @Autowired DepartmentService deptList;
   
   public ModelAndView getDepartment() throws IOException{
    
     ModelAndView mav = new ModelAndView();
     
     mav.setViewName(ForwardConstants.VIEW_HR_DEPT);
     
     return mav;
   }
}
*/