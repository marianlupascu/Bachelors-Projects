package rotl.managers;

import rotl.states.State;

public class StateManager {

	private State actualState;

	public State getActualState() {
		return actualState;
	}

	public void setActualState(State actualState) {
		this.actualState = actualState;
	}
}