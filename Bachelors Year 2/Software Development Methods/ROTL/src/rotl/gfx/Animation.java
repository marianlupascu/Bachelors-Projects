package rotl.gfx;

import java.awt.image.BufferedImage;

public class Animation {

	private BufferedImage[] frames;
	private Integer[] delays;
	private int index = 1;
	private int limit;
	private long last;
	private long now;
	private boolean started = false;

	public Animation(BufferedImage[] frames, Integer[] delays) {
		this.frames = frames;
		this.delays = delays;

		limit = delays.length;
	}

	public void start() {
		started = true;
		last = System.currentTimeMillis();
	}

	public boolean hasStarted() {
		return started;
	}

	public BufferedImage getFrame() {

		now = System.currentTimeMillis();

		if ((now - last) >= delays[index]) {
			++index;
			last = now;
		}

		if (index == limit)
			return null;

		return frames[index];
	}

}
