package com.sharobi.webpos.util;



public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println(round(6.15, 1));
	}
	public static double round(double value, int places) {
	    if (places < 0) throw new IllegalArgumentException();
	    long factor = (long) Math.pow(10, places);
	    value = value * factor;
	    System.out.println("val:"+value);
	    System.out.println("mod:"+value%1);
	    double tmp=value;
	    if(value%1!=0.5)
	    {
	     tmp = Math.round(value);
	    }
	    return (double) tmp / factor;
	}

}
