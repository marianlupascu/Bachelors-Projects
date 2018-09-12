package rotl.gfx;

import java.awt.image.BufferedImage;

import rotl.utilities.ImageLoader;

public class Assets {

	public static BufferedImage[] outsideTiles;
	public static BufferedImage[] buildingTiles;
	public static BufferedImage[] introFrames;
	public static BufferedImage cursor;
	private final int TILE_WIDTH = 64;
	private final int TILE_HEIGHT = 32;

	public void init() {

		int lines, columns;

		// load the outside tiles
		lines = 32;
		columns = 10;

		cursor = ImageLoader.loadImage("/images/cursor_final.png");

		SpriteSheet sheet = new SpriteSheet(ImageLoader.loadImage("/textures/iso-64x64-outside.png"));
		outsideTiles = new BufferedImage[lines * columns + 1];

		for (int i = 0; i < lines; ++i) {
			for (int j = 0; j < columns; ++j) {
				outsideTiles[i * columns + j + 1] = sheet.crop(j * TILE_WIDTH, i * TILE_HEIGHT, TILE_WIDTH,
						TILE_HEIGHT);
			}
		}

		lines = 19;

		introFrames = new BufferedImage[lines + 1];

		for (int i = 1; i <= lines; ++i) {
			introFrames[i - 1] = ImageLoader.loadImage("/images/frame" + i + ".png");
		}

		lines = 57;
		columns = 16;

		buildingTiles = new BufferedImage[lines * columns + 1];
		sheet = new SpriteSheet(ImageLoader.loadImage("/textures/buildings.png"));

		// offset adaugat - TODO

		for (int i = 0; i < lines; ++i) {
			for (int j = 0; j < columns; ++j) {
				buildingTiles[i * columns + j + 1] = sheet.crop(j * TILE_WIDTH, i * TILE_HEIGHT, TILE_WIDTH,
						TILE_HEIGHT);
			}
		}
	}
}
