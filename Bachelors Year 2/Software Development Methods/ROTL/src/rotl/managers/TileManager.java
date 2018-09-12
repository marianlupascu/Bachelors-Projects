package rotl.managers;

import java.awt.Graphics;

import rotl.gfx.Assets;

public class TileManager {

	private Assets assets;

	public TileManager() {

		assets = new Assets();
		assets.init();
	}

	public void render(Graphics g, int x, int y, int index, int layer) {

		switch (layer) {
		case 0:
			g.drawImage(assets.outsideTiles[index], x, y, 64, 32, null);
			break;
		case 1:
			g.drawImage(assets.outsideTiles[index], x, y, 64, 32, null);
			break;
		case 2:
			g.drawImage(assets.buildingTiles[Math.max(0, index - 320)], x, y, 64, 32, null);
		}
	}
}
