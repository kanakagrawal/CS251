import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.awt.geom.*;


public class DrawCircleInGUI {

  private JFrame mainFrame;
  private JLabel statusLabel;
  private JPanel control;
  private JPanel controlPanel1;
  private JPanel controlPanel2;
  private JTextField xdata;
	private JTextField ydata;
	private JTextField raddata;
	private int x;
	private int y;
	private int r;
  private MyCanvas area;

  public DrawCircleInGUI(){
    prepareGUI();
  }

  public static void main(String[] args){
    DrawCircleInGUI drawcircle= new DrawCircleInGUI();       
  }
    
  private void prepareGUI(){
  	mainFrame = new JFrame("Draw a Circle");
	  mainFrame.setSize(800,600);

    statusLabel = new JLabel("",JLabel.CENTER);        
    statusLabel.setSize(800,600);  

		controlPanel1 = new JPanel();
    controlPanel2 = new JPanel(); 

    control = new JPanel();
    control.setLayout(new BoxLayout(control,BoxLayout.PAGE_AXIS));
    control.add(controlPanel1);
    control.add(controlPanel2);
    control.add(statusLabel);

    mainFrame.addWindowListener(new WindowAdapter(){
        public void windowClosing(WindowEvent windowEvent){
          System.exit(0);
        }        
    });  

    mainFrame.addComponentListener(new ComponentAdapter() {
      public void componentResized(ComponentEvent e) { 
        area.redraw();
      }
    });

    xdata= new JTextField(8);
		ydata= new JTextField(8);
		raddata= new JTextField(8);	
		JButton drawbutton = new JButton("Draw");

		drawbutton.setActionCommand("draw");
    drawbutton.addActionListener(new ButtonClickListener());

		controlPanel1.add(new JLabel("x-cordinate:-"));
		controlPanel1.add(xdata);
  	controlPanel1.add(new JLabel("y-cordinate:-"));
  	controlPanel1.add(ydata);
  	controlPanel1.add(new JLabel("Radius"));
  	controlPanel1.add(raddata);
  	controlPanel2.add(drawbutton);

    mainFrame.add(control,BorderLayout.SOUTH);
    mainFrame.setVisible(true);  
  }

  private class MyCanvas extends Canvas {

      public MyCanvas () {
        setSize(mainFrame.getBounds().width,mainFrame.getBounds().height);
      }

      public void paint (Graphics g) {
         Graphics2D g2;
         g2 = (Graphics2D) g;
         g2.setPaint(Color.red);
         g2.drawOval(x-r,y-r,2*r,2*r);
      }

       public void redraw(){
        Graphics g1=this.getGraphics();
        g1.setColor(Color.red);
        g1.drawOval(x-r,y-r,2*r,2*r);
      }
  }


  private class ButtonClickListener implements ActionListener{
    public void actionPerformed(ActionEvent e) {
      String command = e.getActionCommand();  
      if( command.equals("draw")){
				y = Integer.parseInt(ydata.getText());
				x = Integer.parseInt(xdata.getText());
				r = Integer.parseInt(raddata.getText());
        Rectangle re = mainFrame.getBounds();
        int h = re.height;
        int w = re.width;
        if(x+r >w) statusLabel.setText("The circle will be out of draw area. Try different values");
        else if(x-r <0) statusLabel.setText("The circle will be out of draw area. Try different values");
        else if(y+r >h) statusLabel.setText("The circle will be out of draw area. Try different values");
        else if(y-r < 0) statusLabel.setText("The circle will be out of draw area. Try different values");
        else{
  
    		  area = new MyCanvas();     
    			mainFrame.add(area);
          System.out.println("ajay");
        } 
      }
    }	
  }
}	
