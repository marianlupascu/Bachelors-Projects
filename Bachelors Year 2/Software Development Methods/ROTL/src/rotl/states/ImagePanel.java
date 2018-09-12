package rotl.states;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.Toolkit;

import javax.swing.JPanel;

public class ImagePanel extends JPanel {

	Image image;

	public ImagePanel() {
		image = Toolkit.getDefaultToolkit().createImage("/ROTL/resources/images/punchline_intro_final.gif");
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);
		if (image != null) {
			System.out.println("image not null");
			g.drawImage(image, 0, 0, this);
		}
	}

}
