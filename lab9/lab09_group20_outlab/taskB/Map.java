import java.util.*;
import java.lang.*;
import java.io.*;
 
class Map 
{
    int minDistance(int dist[], Boolean check[], int m){
        int min = Integer.MAX_VALUE;
        int min_index=-1;

        for (int v = 0; v < m; v++){
            if (check[v] == false && dist[v] <= min){
                min = dist[v];
                min_index = v;
            }
        }
        return min_index;
    }

    void dijkstra(int time[][], int source, int target, int m){
        int previousVertex[] = new int[m];
        int dist[] = new int[m];
        Boolean check[] = new Boolean[m];
        for (int i = 0; i < m; i++){
            dist[i] = Integer.MAX_VALUE;
            check[i] = false;
            previousVertex[i] = -1;
        }
        dist[source] = 0;
        for(int count = 0; count < m; count++){
            int u = minDistance(dist,check,m);
            check[u] = true;
            for(int v = 0; v < m; v++){
                if (!check[v] && time[u][v]!=0 && dist[u] != Integer.MAX_VALUE && dist[u]+time[u][v] < dist[v]){
                    previousVertex[v] = u;
                    dist[v] = dist[u] + time[u][v];
                }
            }
            if(u==target){
                Vector v = new Vector();
                Vector ans = new Vector();
                v.add(target+1);
                int i = target;
                while(previousVertex[i]!=source){
                    v.add(previousVertex[i]+1);
                    i = previousVertex[i];
                }
                v.add(source+1);
                for(int j = 0;j<v.size();j++){
                    ans.add(v.get(v.size()-j-1));
                }
                source = source+1;
                target = target + 1;
                System.out.println("Total time to reach from vertex " +source + " to vertex "+target+" is "+dist[u]);
                System.out.println("path is: " + ans);
                return;
            }
        }
    }
 
    public static void main (String[] args)
    {
       try{
            File file = new File("input.txt");
            Scanner in = new Scanner(file);
            int m = in.nextInt();
            int n = in.nextInt();
            int s = in.nextInt();
            int t = in.nextInt();
            int edgeTime[][] = new int[m][m];
            for(int i = 0;i<n;i++){
                int v1 = in.nextInt();
                int v2 = in.nextInt();
                int e = in.nextInt();
                edgeTime[v1-1][v2-1] = e;
                edgeTime[v2-1][v1-1] = edgeTime[v1-1][v2-1];
            }
            Map p = new Map();
            p.dijkstra(edgeTime, s-1, t-1, m);
            // System.out.println("Total time to reach from vertex " + s+ " to vertex "+t+" is "+answer);
       }
       catch(Exception e){
        System.out.println("Error: file missing or error in input format");
       }
    }
}