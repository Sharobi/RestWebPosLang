/**
 * 
 */
package com.sharobi.webpos.util;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;


/**
 * @author habib
 *
 */
public class CustomTag extends SimpleTagSupport{
	
	private double number;
	private int place;
	
	@Override
	public void doTag() throws JspException, IOException {
		if (place < 0) throw new IllegalArgumentException();
		long factor = (long) Math.pow(10, place);
		number = number * factor;
	    double tmp=number;
	    if(number%1!=0.5)
	    {
	     tmp = Math.round(number);
	    }
	    getJspContext().getOut().println(""+(double) tmp / factor);
	    //return (double) tmp / factor;
		//super.doTag();
	}

	public void setNumber(double number) {
		this.number = number;
	}

	public void setPlace(int place) {
		this.place = place;
	}

}
