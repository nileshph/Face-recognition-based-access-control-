package com.facedetection.cv;

import java.io.File;
import java.util.concurrent.Future;
import com.mathworks.engine.MatlabEngine;

public class SearchFacesService {

   private static final String PATH_TO_PROCESS = System.getProperty("user.dir") + "/faces";
   
   public String search() throws Exception {
      long start = System.currentTimeMillis();

      String nameofperson = "";

      File dir = new File(PATH_TO_PROCESS);
      if (dir.isDirectory()) {
    	  //MatlabInt mint = new MatlabInt();
    	  System.out.println("dir name param is:" + dir.toString());
    	  String[] engines = MatlabEngine.findMatlab();
          MatlabEngine ml = MatlabEngine.connectMatlab(engines[0]);
             double input = 3;
             ml.putVariableAsync("A", input);
             ml.eval("B=test(A)");
             Future<String> futureEval = ml.getVariableAsync("B");
             nameofperson = futureEval.get();
             ml.close();
             
      } else {
         throw new RuntimeException("Provided path is not a directory");
      }
      long stop = System.currentTimeMillis();
      System.out.println("Time in ms for search:" + (stop - start));
      for (final File photo : dir.listFiles()) {
         photo.delete();
      }
      return nameofperson;
   }
}
