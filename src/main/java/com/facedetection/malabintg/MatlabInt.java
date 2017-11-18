package com.facedetection.malabintg;

import com.mathworks.toolbox.javabuilder.*;
import test.Testclass;

public class MatlabInt {


	public static void main(String[] args) throws MWException
	{
		Testclass tt = new Testclass();

		MWCharArray n = new MWCharArray("dummy");

		Object[] x = tt.test(1, n);
		
		System.out.println(x[0]);

	}

	public String getImageName(String dirname) throws MWException
	{
		Testclass tt = new Testclass();

		MWCharArray n = new MWCharArray("dummy");

		Object[] x = tt.test(1, n);
		
		return x[0].toString();

	}

}
