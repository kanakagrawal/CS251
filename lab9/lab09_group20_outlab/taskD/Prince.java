import java.io.*;
import java.net.*;

public class Prince {

  public static void main(String[] args) throws Exception {

   URL aa = new URL("https://www.cse.iitb.ac.in/~sharat/current/cs251/Assign/Lab09/support/Prince.php");
   InputStream in = aa.openStream();
   OutputStream out =new FileOutputStream("secret.txt");
   int c;
   while ((c = in.read()) != -1) {
      out.write(c);
   }
    
   in.close();
   out.close();
  }

}