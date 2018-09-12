package rotl.states;

import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionListener;

import rotl.buttons.ExitButton;
//import rotl.buttons.ExitButton;
import rotl.gfx.Assets;
import rotl.managers.TileManager;
import rotl.statusBar.StatusBar;
import rotl.utilities.Handler;
import rotl.utilities.XMLLoader;
import rotl.utilities.XMLParser;

public class GameState extends State {

	private TileManager tileManager;

	private final int NO_OF_LAYERS;

	private final int TILE_WIDTH = 64, TILE_HEIGHT = 32;

	private int width, height;

	private Rectangle east, west, south, north, southEast, southWest, northWest, northEast;

	private double offsetAmount = 0.01;

	private float cameraXOffset = 0, cameraYOffset = 0;
	
	private ExitButton exitButton;

	private int[][][] layers;
	Assets a = new Assets();

	public GameState(int width, int height, Handler handler) {
		super(handler);

		this.width = width;
		this.height = height;

		tileManager = new TileManager();
		XMLLoader load = new XMLLoader();
		layers = load.loadXMLMaps("/maps/mapp.xml");
		NO_OF_LAYERS = load.getNoOfLayers();
		a.init();
		
		exitButton = new ExitButton(handler);

		buildDirectionRectangles();
		addEventListeners();

		MenuState.changeState();
		StatusBar.getInstance(handler);
		
		/** parse soldiers info **/
		
		final String soldiersPath = "resources\\entities_info\\soldiers.xml";
		final String towersPath = "resources\\entities_info\\towers.xml";
		XMLParser.parseSoldiersInfo(soldiersPath);
		XMLParser.parseTowersInfo(towersPath);
	}

	private void buildDirectionRectangles() {

		north = new Rectangle(width / 4, 0, width / 2, height / 4);
		south = new Rectangle(width / 4, (height / 4) * 3, width / 2, height / 4);
		east = new Rectangle(0, height / 4, width / 4, height / 2);
		west = new Rectangle((width / 4) * 3, height / 4, width / 4, height / 2);
		northEast = new Rectangle(0, 0, width / 4, height / 4);
		southEast = new Rectangle(0, (height / 4) * 3, width / 4, height / 4);
		northWest = new Rectangle((width / 4) * 3, 0, width / 4, height / 4);
		southWest = new Rectangle((width / 4) * 3, (height / 4) * 3, width / 4, height / 4);
	}

	private void addEventListeners() {

		handler.getGame().getDisplay().getCanvas().addMouseMotionListener(new MouseMotionListener() {

			@Override
			public void mouseDragged(MouseEvent arg0) {

			}

			@Override
			public void mouseMoved(MouseEvent event) {

				Point mousePosition = event.getPoint();

				if (north.contains(mousePosition)) {
					// handler.getGame().getGameCamera().move(0, (float)-offsetAmount);
					cameraYOffset -= offsetAmount;
					return;
				} else if (east.contains(mousePosition)) {
					// handler.getGame().getGameCamera().move((float)offsetAmount, 0);
					cameraXOffset -= offsetAmount;
					return;
				} else if (south.contains(mousePosition)) {
					// handler.getGame().getGameCamera().move(0, (float)offsetAmount);
					cameraYOffset += offsetAmount;
					return;
				} else if (west.contains(mousePosition)) {
					// handler.getGame().getGameCamera().move((float)-offsetAmount, 0);
					cameraXOffset += offsetAmount;
					return;
				}

				/*
				 * if(northWest.contains(mousePosition)) { cameraXOffset += offsetAmount;
				 * cameraYOffset -= offsetAmount; return; }
				 * if(northEast.contains(mousePosition)) { cameraXOffset -= offsetAmount;
				 * cameraYOffset -= offsetAmount; return; }
				 * if(southWest.contains(mousePosition)) {
				 * handler.getGame().getGameCamera().move((float)offsetAmount,
				 * (float)offsetAmount); cameraXOffset += offsetAmount; cameraYOffset +=
				 * offsetAmount; return; } if(southEast.contains(mousePosition)) { cameraXOffset
				 * -= offsetAmount; cameraYOffset += offsetAmount; return; }
				 */

				cameraXOffset = cameraYOffset = 0;
			}
		});
	}

	@Override
	public void update() {

		if (Math.abs(cameraXOffset) > 0.2) {
			cameraXOffset = (float) 0.2 * (cameraXOffset < 0 ? -1 : 1);
		}
		if (Math.abs(cameraYOffset) > 0.5) {
			cameraYOffset = (float) 0.5 * (cameraYOffset < 0 ? -1 : 1);
		}

		handler.getGame().getGameCamera().move(cameraXOffset, cameraYOffset);
		
		exitButton.update();
	}

	@Override
	public void render(Graphics g) {

		g.clearRect(0, 0, width, height);

		int startHeight = Math.max((int) (handler.getGame().getGameCamera().getYOffset() / (TILE_HEIGHT / 2)) - 1, 0);
		int startWidth = Math.max((int) (handler.getGame().getGameCamera().getXOffset() / TILE_WIDTH) - 1, 0);

		for (int k = 0; k < NO_OF_LAYERS; ++k) {
			for (int i = startHeight; i <= (startHeight + height / 16 + 2); ++i) {
				for (int j = startWidth; j <= (startWidth + width / 64 + 2); ++j) {
					int offset;
					if ((int) (handler.getGame().getGameCamera().getYOffset() + i) % 2 == 0)
						offset = 0;
					else
						offset = 32;
					tileManager.render(g,
							-32 + offset + (int) (j * TILE_WIDTH - handler.getGame().getGameCamera().getXOffset()),
							-16 + (int) ((i * (TILE_HEIGHT / 2)) - handler.getGame().getGameCamera().getYOffset()),
							layers[(int) (handler.getGame().getGameCamera().getYOffset() + i)][(int) (j
									+ handler.getGame().getGameCamera().getXOffset())][k],
							k);
					// tileManager.render(g, -32 + offset + j * 64,-16 + i * 16, layers[i][j][k],
					// k);
				}
			}
		}

		exitButton.render(g);
		
		/*
		 * if(n) { g.fillRect(width / 4, 0, width / 2, height / 4); }else {
		 * g.drawRect(width / 4, 0, width / 2, height / 4); }
		 * 
		 * if(s) { g.fillRect(width / 4, (height / 4) * 3, width / 2, height / 4); }else
		 * { g.drawRect(width / 4, (height / 4) * 3, width / 2, height / 4); }
		 * 
		 * if(w) { g.fillRect((width / 4) * 3, height / 4, width / 4, height / 2); }else
		 * { g.drawRect((width / 4) * 3, height / 4, width / 4, height / 2); }
		 * 
		 * if(e) { g.fillRect(0, height / 4, width / 4, height / 2); }else {
		 * g.drawRect(0, height / 4, width / 4, height / 2); }
		 */

	}

}