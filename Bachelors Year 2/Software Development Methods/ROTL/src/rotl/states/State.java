package rotl.states;

import java.awt.Graphics;

import rotl.utilities.Handler;

public abstract class State {

	protected Handler handler;

	public State(Handler handler) {
		this.handler = handler;
	}

	public abstract void update();

	public abstract void render(Graphics g);
}