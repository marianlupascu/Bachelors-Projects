package rotl.buttons;

import java.awt.Graphics;

public interface Button {

	public void render(Graphics g);
	public void update();
	public void buildListenerRectangle();
}
