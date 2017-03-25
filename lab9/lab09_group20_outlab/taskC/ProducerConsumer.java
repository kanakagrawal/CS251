import java.util.LinkedList; 
import java.util.Queue; 
import java.util.Random; 

public class ProducerConsumer{
	public static void main(String args[]){
		Queue<Integer> buffer = new LinkedList<>();
		int maxSize = 5; 
		Thread producer = new Producer(buffer, maxSize, "PRODUCER"); 
		Thread consumer = new Consumer(buffer, maxSize, "CONSUMER"); 
		producer.start(); 
		consumer.start(); 
	}
} 

class Producer extends Thread { 
	private String threadname;
	private Thread t;
	private Queue<Integer> queue; 
	private int maxSize; 

	public Producer(Queue<Integer> queue, int maxSize, String name){ 
		super(name); 
		this.threadname = name; 
		this.queue = queue; 
		this.maxSize = maxSize; 
	}

	public void run(){ 
		while(true){ 
			synchronized(queue){ 
				while(queue.size() == maxSize){ 
					try{ 
						System.out .println("Queue is full, Producer thread is waiting for the consumer to take something from queue"); 
						queue.wait(); 
					} 
					catch(Exception e){ 
						e.printStackTrace(); 
					} 
				} 
				Random random = new Random(); 
				int i = random.nextInt(); 
				System.out.println("Producing value, number of items in buffer =  " + queue.size()); 
				queue.add(i); 
				queue.notifyAll(); 
				try{
					Thread.sleep(1);	
				} 
				catch(Exception ex){}
			}
		}
	}

	public void start(){
		if(t == null){
			t = new Thread (this,threadname);
			t.start ();
		}
   	}
}

class Consumer extends Thread{
	private String threadname;
	private Thread t;
	private Queue<Integer> queue; 
	private int maxSize; 

	public Consumer(Queue<Integer> queue, int maxSize, String name){ 
		super(name);
		this.threadname = name; 
		this.queue = queue; 
		this.maxSize = maxSize; 
	}

	public void run(){ 
		while(true){ 
			synchronized(queue){ 
				while(queue.isEmpty()){ 
					System.out.println("Queue is empty,Consumer thread is waiting for producer thread to put something in queue"); 
					try{
						queue.wait(); 
					}
					catch(Exception ex){ 
						ex.printStackTrace(); 
					}
				}
				queue.remove();
				System.out.println("Consuming value, number of items in buffer =  " + queue.size());
				queue.notifyAll();
				try{
					Thread.sleep(1);	
				} 
				catch(Exception e){}
			}
		}
	}

	public void start () {
    	if(t == null){
        	t = new Thread (this,threadname);
        	t.start ();
        }
   	}
}