package rotl.gfx;

public class GameCamera {

	private float xOffset, yOffset;

	public GameCamera(float xOffset, float yOffset) {

		this.xOffset = xOffset;
		this.yOffset = yOffset;
	}

	public void move(float xAmount, float yAmount) {
		xOffset += xAmount;
		yOffset += yAmount;

		xOffset = Math.max((float) 0, xOffset);
		yOffset = Math.max((float) 0, yOffset);
	}

	public float getXOffset() {
		return xOffset;
	}

	public float getYOffset() {
		return yOffset;
	}

	public void setXOffset(float xOffset) {
		this.xOffset = xOffset;
	}

	public void setYOffset(float yOffset) {
		this.yOffset = yOffset;
	}

	public void setOffsets(float xOffset, float yOffset) {
		this.xOffset = xOffset;
		this.yOffset = yOffset;
	}
}
