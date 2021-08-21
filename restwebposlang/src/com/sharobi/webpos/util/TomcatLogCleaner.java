/**
 * 
 */
package com.sharobi.webpos.util;

import java.io.File;
import java.io.FilenameFilter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;



/**
 * @author habib
 *
 */
public class TomcatLogCleaner extends TimerTask {
	private final static Logger logger = LogManager.getLogger(TomcatLogCleaner.class);
	  //private static final String DEFAULT_LOG_FILE_PATTERN = "localhost_access_log\\.yyyy-MM-dd\\.txt";
	  private static final String DEFAULT_LOG_FILE_PATTERN = ".*\\.yyyy-MM-dd\\...*";
	  private static final String DEFAULT_DATE_FORMAT = "yyyy-MM-dd";
	  private String dateFormat;
	  private Pattern logFilePat;
	  private File logFileDir;
	  private int numBackups;
	  int noofdaysbefore;
	  public TomcatLogCleaner(File logFileDir, int numBackups,int noofdaysbefore) {
	    this(logFileDir, DEFAULT_LOG_FILE_PATTERN, DEFAULT_DATE_FORMAT, numBackups,noofdaysbefore);
	  	}
	 
	  public TomcatLogCleaner(File logFileDir, String logFilePattern, String dateFormat, int numBackups,int noofdaysbefore) {
	    this.dateFormat = dateFormat;
	    this.logFileDir = logFileDir;
	    String pat = logFilePattern.replace(dateFormat, "(.+?)");
	    logFilePat = Pattern.compile(pat);
	    this.numBackups = numBackups;
	    this.noofdaysbefore = noofdaysbefore;
	  	}
	 
	  public void clean() {
		  logger.info("Starting to clean old Tomcat access logs. Number of backups to keep: " + numBackups);
		  File[] files = logFileDir.listFiles(new FilenameFilter() {
			  
		      public boolean accept(File dir, String file) {  
		    	  return logFilePat.matcher(file).matches();
		      }
		  });
		  List<LogFile> logFiles = new ArrayList<LogFile>(files != null ? files.length : 10);
		  for (File file : files) {
			  try {
				  LogFile logFile = new LogFile(file, logFilePat, dateFormat);
				  logFiles.add(logFile);
			  	  }  
			  		catch (ParseException pe) {
			  		}
		  		} 
	 
		  Collections.sort(logFiles, new Comparator<LogFile>() { 
			  @Override
			  public int compare(LogFile o1, LogFile o2) {
				  return o1.getLogDate().compareTo(o2.getLogDate());
			  	}
		  });
		  System.out.println("logFiles.size():"+logFiles.size());
	    int numFilesToClean = logFiles.size() - numBackups;
	    int removed = 0;
	    Date calDate=getCalculatedDate(noofdaysbefore);
	    for (int i = 0; i < numFilesToClean; i++) {
	    	LogFile logFile = logFiles.get(i);
	    	logger.info("Deleting access log file: " + logFile.toString());
	    	if(calDate.getTime()>=logFile.getLogDate().getTime())
	    	{
	    		try{
		    	if (!logFile.getFile().delete()) {
		    		logger.warn("Failed deleting log file");
		    		}
		    	else
		    	{
		    	removed++;
		    	}
	    		}catch (Exception e) {
					e.printStackTrace();
				}
	    	}
	    	}
	    
	    logger.info("Finished cleaning old Tomcat logs. Total log files: " +
	    		logFiles.size() + ". Deleted: " + removed + " of " + Math.max(0, numFilesToClean));
	  	}
	 
	  public Date getCalculatedDate(int noofdaysbefore)
	  {
		  Calendar c = Calendar.getInstance();
		  c.add(Calendar.DAY_OF_MONTH, -noofdaysbefore);
		  return c.getTime();
	  }
	  
	  public static class LogFile {
	  private File file;
	  private Date logDate;
	  public LogFile(File file, Pattern pattern, String dateFormat) throws ParseException {
		  Matcher matcher = pattern.matcher(file.getName());
		  	if (matcher.find()) {
		  		String dateStr = matcher.group(1);
		  		SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
		  		logDate = sdf.parse(dateStr);
		  		this.file = file;
		  		}
	  		}
	 
	  public File getFile() {
	    return file;
	  }
	 
	  public void setFile(File file) {
	    this.file = file;
	  } 
	 
	  public Date getLogDate() {
	    return logDate;
	  }
	 
	  public void setLogDate(Date logDate) {
	    this.logDate = logDate;
	  }

	@Override
	public String toString() {
		return "LogFile [file=" + file + ", logDate=" + logDate + "]";
	}
	  
	  
	} 
	 
	  public void run() {
		  clean();
	  		}
	}
