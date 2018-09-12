package rotl.utilities;

import rotl.game.Game;
import rotl.managers.StateManager;

public class Handler {

	private StateManager stateManager;
	private Game game;

	public Handler(StateManager stateManager, Game game) {
		this.stateManager = stateManager;
		this.game = game;
	}

	public StateManager getStateManager() {
		return stateManager;
	}

	public Game getGame() {
		return game;
	}
}