package com.learnonline.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;

import com.learnonline.exceptions.CustomException;

import jakarta.servlet.http.Part;

public class Helper {
	
	public static String generateFileName(Part file) {
		String[] fileFullName = file.getSubmittedFileName().split("\\.");
		
		String extension = fileFullName[fileFullName.length - 1];
		System.out.println(extension);
		if(!extension.equals("png") && !extension.equals("jpeg") && !extension.equals("jpg")) {
			throw new CustomException("Invalid file provided image is expected...");
		}

		fileFullName[fileFullName.length - 1] = "";

		String filename = String.join("", fileFullName);
		String uniqueFileName = filename + "-" + new Date().getTime() + "." + extension;
		
		return uniqueFileName;
	}

	public static boolean deleteFile(String path) {
		boolean isDeleted = false;

		try {
			File file = new File(path);
			isDeleted = file.delete();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isDeleted;
	}

	public static boolean saveFile(InputStream is, String path) {

		boolean isSaved = false;

		try {

			byte b[] = new byte[is.available()];
			is.read(b);

			FileOutputStream fos = new FileOutputStream(path);
			fos.write(b);
			fos.flush();
			fos.close();
			isSaved = true;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return isSaved;
	}

}
