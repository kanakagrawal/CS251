import java.io.*;
import java.util.*;
import java.math.*;

public class math{
	public static void main(String[] args) throws IOException{
		File file = new File("input.txt");
		File file2 = new File("output.txt");
		Scanner in = new Scanner(file);
		FileWriter fWriter = new FileWriter (file2);
		PrintWriter pWriter = new PrintWriter (fWriter);
		int t;
		String s = in.nextLine();
		try{
			t = Integer.parseInt(s);
			if(t<=0){
				pWriter.println("Invalid value: number of test cases cannot be negative");
				return;
			}
			while(t>0){
				int m,n;
				try{
					m = in.nextInt();
					try{
						n = in.nextInt();
					}
					catch(InputMismatchException esa){
						pWriter.println("Invalid value: n cannot be decimal");
						try{
							String temp = in.nextLine();
						}
						catch(InputMismatchException easa){}
						t = t-1;
						continue;
					}
				}
				catch(InputMismatchException esa){
					pWriter.println("Invalid value: m cannot be decimal");
					try{
							String temp = in.nextLine();
						}
						catch(InputMismatchException e){}
					t = t-1;
					continue;
				}
				if(m<=0){
					pWriter.println("Invalid value: m cannot be negative");
					t = t-1;
					continue;
				}
				if(n<=0){
					pWriter.println("Invalid value: n cannot be negative");
					t = t-1;
					continue;
				}
				if(m<n+5 || n<5){
					pWriter.println("Invalid value: n should be between 5 and m-5");
					t = t-1;
					continue;
				}
				BigInteger answer;
				answer = new BigInteger("0");
				int j = n - 5;
				while(j<=n+5){
					BigInteger a;
					a = new BigInteger("1");
					for(int i = 1;i<=j;i++){
						String sa = Integer.toString(m-i+1);
						a = a.multiply(new BigInteger(sa));
						sa = Integer.toString(i);
						a = a.divide(new BigInteger(sa));
					}
					answer = answer.add(a);
					j = j+1;
				}
				pWriter.println(answer);
				t = t-1;
			}
		}
		catch(Exception e){
			pWriter.println("Invalid value: number of test cases should be a positive integer");
		}
		pWriter.close();
	}
}