package demo1;
import java.util.Random;

public class thought {
    public static void main(String[] args) {
	int[] cell = new int[10000000];
	int[] innerCell = new int[1000000];
	Random randomObject = new Random(123); 
	// seed DO NOT CHANGE
	Loop[] th =  new Loop[1000];
	for (int i=0; i<1000; i++) {
	    int randomNum=randomObject.nextInt(100000)+1;
	    // inner loop.. you can't skip this  piece of code
	    // Voldemort (er, J K Rowling) has mandated it
	    th[i] = new Loop(i,randomNum,cell,innerCell);
	    th[i].start();
	}
    } // end main
} // end class
