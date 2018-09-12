package rotl.menu;

import java.awt.Graphics;

public interface MenuOption {

	static final Integer fontSize = 25;
	static final Integer titleFontSize = 100;

	void Init();

	public void paintComponent(Graphics g);

}
