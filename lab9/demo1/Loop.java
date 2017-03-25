package demo1;
import java.util.Random;

public class Loop extends Thread{
	private Thread t;
	private int[] cell;
	private int[] innerCell;
	private int randomNum;
	private int iterator;


	Loop(int i, int r, int[] ce, int[] innerce) {
		iterator = i;
		randomNum = r;
		cell = ce;
		innerCell = innerce;
	}
   
   	public void run() {
        	for (int j = 0; j < 1000000; j++) { 
				Random innerrandomObject = new Random(200);
				int innerrandomNum = innerrandomObject.nextInt(4000)+1;
				innerCell[j] = iterator%innerrandomNum;
	    	}
	    	cell[iterator] = randomNum;
	    	if (cell[iterator] == 3523) { // Voldemort key is 3523
				System.out.println(iterator);
	    	}
   }
   
   public void start () {
      if (t == null) {
         t = new Thread (this, Integer.toString(iterator));
         t.start ();
      }
   }
} // end class
