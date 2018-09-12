package rotl.buttons;

import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;

import rotl.states.MenuState;
import rotl.statusBar.StatusBar;
import rotl.utilities.Handler;
import rotl.utilities.ImageLoader;

public class ExitButton implements Button{

	private BufferedImage icon;
	private Rectangle position;
	private final int POS_X = 5, POS_Y = 5;
	private final int INIT_WIDTH = 64, INIT_HEIGHT = 32;
	private final int HOVER_WIDTH = 80, HOVER_HEIGHT = 64;
	private int actualWidth, actualHeight;
	
	private Handler handler;
	
	public ExitButton(Handler handler) {
		
		this.handler = handler;
		
		icon = ImageLoader.loadImage("/images/goBack.png");
		
		actualWidth = INIT_WIDTH;
		actualHeight = INIT_HEIGHT;
		
		buildListenerRectangle();
		addMouseListener();
	}

	private void addMouseListener() {
		
		handler.getGame().getDisplay().getCanvas().addMouseListener(new MouseListener() {

			@Override
			public void mouseClicked(MouseEvent event) {
				Point mousePosition = event.getPoint();
				
				if(position.contains(mousePosition)){
					handler.getStateManager().setActualState(new MenuState(handler));
					MenuState.changeState();
					StatusBar.changeVisibility(false);
				}
			}
			
			@Override
			public void mouseEntered(MouseEvent arg0) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void mouseExited(MouseEvent arg0) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void mousePressed(MouseEvent arg0) {
				// TODO Auto-generated method stub
				
			}

			@Override
			public void mouseReleased(MouseEvent arg0) {
				// TODO Auto-generated method stub
				
			}
		});
	}
	
	@Override
	public void render(Graphics g) {
		g.drawImage(icon, POS_X, POS_Y, INIT_WIDTH, INIT_HEIGHT, null);
	}

	@Override
	public void update() {
	}

	@Override
	public void buildListenerRectangle() {
		position = new Rectangle(POS_X, POS_Y, INIT_WIDTH, INIT_HEIGHT);
	}

}
