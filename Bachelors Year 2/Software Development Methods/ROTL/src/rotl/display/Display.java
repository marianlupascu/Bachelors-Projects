package rotl.display;

import java.awt.Canvas;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Image;
import java.awt.Point;
import java.awt.Toolkit;

import javax.swing.JFrame;

public class Display {

	private JFrame frame;
	private Canvas canvas;

	private String title;
	private int screenWidth, screenHeight;

	public Display(String title) {
		this.title = title;
		createDisplay();
	}

	private void createDisplay() {

		// get the screen's max resolution
		Dimension screenMaxResolution = Toolkit.getDefaultToolkit().getScreenSize();
		screenWidth = (int) screenMaxResolution.getWidth();
		screenHeight = (int) screenMaxResolution.getHeight();

		frame = new JFrame(title);

		// change the cursor
		Image image = Toolkit.getDefaultToolkit().getImage(getClass().getResource("/images/cursor_final.png"));
		Point hotspot = new Point(0, 0);
		Cursor cursor = Toolkit.getDefaultToolkit().createCustomCursor(image, hotspot, "pencil");
		frame.setCursor(cursor);

		setFrameSize(screenWidth, screenHeight);

		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setResizable(false);
		frame.setExtendedState(JFrame.MAXIMIZED_BOTH);
		frame.setUndecorated(true);
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);

		canvas = new Canvas();
		setCanvasSize(screenWidth, screenHeight);
		canvas.setFocusable(false);

		frame.add(canvas);
	}

	public void setCanvasSize(int width, int height) {

		canvas.setPreferredSize(new Dimension(width, height));
		canvas.setMinimumSize(new Dimension(width, height));
		canvas.setMaximumSize(new Dimension(width, height));
	}

	public void setFrameSize(int width, int height) {

		frame.setPreferredSize(new Dimension(width, height));
		frame.setMinimumSize(new Dimension(width, height));
		frame.setMaximumSize(new Dimension(width, height));
	}

	// GETers
	public int getWidth() {
		return screenWidth;
	}

	public int getHeight() {
		return screenHeight;
	}

	public Canvas getCanvas() {
		return canvas;
	}

	public JFrame getFrame() {
		return frame;
	}

	public void setScreenSize(int width, int height) {

		screenWidth = width;
		screenHeight = height;

		setFrameSize(screenWidth, screenHeight);
		setCanvasSize(screenWidth, screenHeight);
		frame.pack();
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);
	}
}