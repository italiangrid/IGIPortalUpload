package it.italiangrid.portal.controller;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.portlet.RenderResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;


/**
 * This class is the controller that authenticate the user and display some
 * information about the downloaded proxyes.
 * 
 * @author dmichelotto
 * 
 */

@Controller("uploadController")
@RequestMapping(value = "VIEW")
public class UploadController {
	

	/**
	 * Logger of the class DownloadCertificateController. TODO to substitute it
	 * with slf4j.
	 */
	private static final Logger log = LoggerFactory.getLogger(UploadController.class);

	

	/**
	 * Method for render home.jsp page.
	 * 
	 * @return the page file name.
	 */
	@RenderMapping
	public String showUpload(RenderResponse response) {
		return "home";
	}
	

	

}
