package rotl.states;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.URL;

import javax.imageio.ImageIO;

import rotl.menu.HallOfFame;
import rotl.menu.Instructions;
import rotl.menu.Options;
import rotl.utilities.Handler;

public class MenuState extends State {

	private static boolean inMenuState = true;

	private static int MenuDimensionX;
	private static int MenuDimensionY;
	private static BufferedImage backgroundImg;
	private static BufferedImage playButton;
	private static BufferedImage optionsButton;
	private static BufferedImage instructionButton;
	private static BufferedImage highScoreButton;
	private static BufferedImage exitButton;

	private boolean start, options, instructions, highScores, exit;
	private static int xMenu, yMenu;
	private static int screenWidth, screenHeight;
	private final int textSize = 48;

	public MenuState(Handler handler) {
		super(handler);

		Init();

		start = true;
		options = instructions = highScores = exit = false;

		screenWidth = handler.getGame().getWidth();
		screenHeight = handler.getGame().getHeight();

		xMenu = (int) (screenWidth * 10 / 100);
		yMenu = (int) (screenWidth * 20 / 100);

		MenuDimensionX = (int) (screenWidth * 30 / 100);
		MenuDimensionY = (int) (screenHeight * 60 / 100);

		addHandlers();
	}

	public void addHandlers() {

		handler.getGame().getDisplay().getCanvas().addMouseMotionListener(new MouseMotionListener() {

			@Override
			public void mouseDragged(MouseEvent event) {
			}

			@Override
			public void mouseMoved(MouseEvent event) {
				Point mousePosition = event.getPoint();

				if (playButton != null) {
					Rectangle bounds = new Rectangle(xMenu + (int) (screenWidth * 2 / 100),
							yMenu + (int) (screenHeight * 1 / 100), MenuDimensionX - 2 * (int) (screenWidth * 2 / 100),
							(int) (MenuDimensionY / 6));
					if (bounds.contains(mousePosition)) {
						start = true;
					} else {
						start = false;
					}
				}

				if (optionsButton != null) {
					Rectangle bounds = new Rectangle(xMenu + (int) (screenWidth * 2 / 100),
							yMenu + 2 * (int) (screenHeight * 1 / 100) + (int) (MenuDimensionY / 6),
							MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6));
					if (bounds.contains(mousePosition)) {
						options = true;
					} else {
						options = false;
					}
				}

				if (instructionButton != null) {
					Rectangle bounds = new Rectangle(xMenu + (int) (screenWidth * 2 / 100),
							yMenu + 3 * (int) (screenHeight * 1 / 100) + 2 * (int) (MenuDimensionY / 6),
							MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6));
					if (bounds.contains(mousePosition)) {
						instructions = true;
					} else {
						instructions = false;
					}
				}

				if (highScoreButton != null) {
					Rectangle bounds = new Rectangle(xMenu + (int) (screenWidth * 2 / 100),
							yMenu + 4 * (int) (screenHeight * 1 / 100) + 3 * (int) (MenuDimensionY / 6),
							MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6));
					if (bounds.contains(mousePosition)) {
						highScores = true;
					} else {
						highScores = false;
					}
				}

				if (exitButton != null) {
					Rectangle bounds = new Rectangle(xMenu + (int) (screenWidth * 2 / 100),
							yMenu + 5 * (int) (screenHeight * 1 / 100) + 4 * (int) (MenuDimensionY / 6),
							MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6));
					if (bounds.contains(mousePosition)) {
						exit = true;
					} else {
						exit = false;
					}
				}
			}
		});

		handler.getGame().getDisplay().getCanvas().addMouseListener(new MouseListener() {

			@Override
			public void mouseClicked(MouseEvent event) {

				if (start && inMenuState) {
					handler.getStateManager().setActualState(
							new GameState(handler.getGame().getWidth(), handler.getGame().getHeight(), handler));
				}
				if (options && inMenuState) {
					Options.getOptions(handler);
				}
				if (instructions && inMenuState) {
					Instructions.getInstructions(handler);
				}
				if (highScores && inMenuState) {
					HallOfFame.getHallOfFame(handler);
				}
				if (exit && inMenuState) {
					System.exit(0);
				}
			}

			@Override
			public void mouseEntered(MouseEvent arg0) {

			}

			@Override
			public void mouseExited(MouseEvent arg0) {

			}

			@Override
			public void mousePressed(MouseEvent arg0) {

			}

			@Override
			public void mouseReleased(MouseEvent arg0) {

			}

		});
	}

	@Override
	public void update() {
	}

	@Override
	public void render(Graphics g) {

		g.drawImage(backgroundImg, 0, 0, screenWidth, screenHeight, null);

		g.setFont(new Font("Neuropol X", Font.BOLD, 100));
		g.setColor(Color.WHITE);
		g.drawString("Menu", (int) (xMenu * 150 / 100), yMenu - 50);

		g.setColor(new Color(255, 255, 255, 100));
		g.fillRect(xMenu - (int) (MenuDimensionX * 2 / 100), yMenu - (int) (MenuDimensionY * 30 / 100),
				MenuDimensionX + (int) (MenuDimensionX * 2 / 100), (int) (MenuDimensionY * 1.25));

		g.setFont(new Font("Neuropol X", Font.BOLD, 125));
		g.setColor(new Color(41, 168, 222, 200));
		g.drawString("Return of", xMenu + (int) (MenuDimensionX * 120 / 100), (int) ((yMenu + MenuDimensionY) * 1 / 3));
		g.drawString("the legends", xMenu + (int) (MenuDimensionX * 120 / 100),
				(int) ((yMenu + MenuDimensionY) * 1 / 3) + 75);

		if (start) {
			g.drawImage(playButton, xMenu + (int) (screenWidth * 2 / 100) + 5,
					yMenu + (int) (screenHeight * 1 / 100) + 3, MenuDimensionX - 2 * (int) (screenWidth * 2 / 100) - 10,
					(int) (MenuDimensionY / 6) - 6, null);
		} else {
			g.drawImage(playButton, xMenu + (int) (screenWidth * 2 / 100), yMenu + (int) (screenHeight * 1 / 100),
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6), null);
		}
		if (options) {
			g.drawImage(optionsButton, xMenu + (int) (screenWidth * 2 / 100) + 5,
					yMenu + 2 * (int) (screenHeight * 1 / 100) + (int) (MenuDimensionY / 6) + 3,
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100) - 10, (int) (MenuDimensionY / 6) - 6, null);
		} else {
			g.drawImage(optionsButton, xMenu + (int) (screenWidth * 2 / 100),
					yMenu + 2 * (int) (screenHeight * 1 / 100) + (int) (MenuDimensionY / 6),
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6), null);
		}
		if (instructions) {
			g.drawImage(instructionButton, xMenu + (int) (screenWidth * 2 / 100) + 5,
					yMenu + 3 * (int) (screenHeight * 1 / 100) + 2 * (int) (MenuDimensionY / 6) + 3,
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100) - 10, (int) (MenuDimensionY / 6) - 6, null);
		} else {
			g.drawImage(instructionButton, xMenu + (int) (screenWidth * 2 / 100),
					yMenu + 3 * (int) (screenHeight * 1 / 100) + 2 * (int) (MenuDimensionY / 6),
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6), null);
		}
		if (highScores) {
			g.drawImage(highScoreButton, xMenu + (int) (screenWidth * 2 / 100) + 5,
					yMenu + 4 * (int) (screenHeight * 1 / 100) + 3 * (int) (MenuDimensionY / 6) + 3,
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100) - 10, (int) (MenuDimensionY / 6) - 6, null);
		} else {
			g.drawImage(highScoreButton, xMenu + (int) (screenWidth * 2 / 100),
					yMenu + 4 * (int) (screenHeight * 1 / 100) + 3 * (int) (MenuDimensionY / 6),
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6), null);
		}
		if (exit) {
			g.drawImage(exitButton, xMenu + (int) (screenWidth * 2 / 100) + 5,
					yMenu + 5 * (int) (screenHeight * 1 / 100) + 4 * (int) (MenuDimensionY / 6) + 3,
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100) - 10, (int) (MenuDimensionY / 6) - 6, null);
		} else {
			g.drawImage(exitButton, xMenu + (int) (screenWidth * 2 / 100),
					yMenu + 5 * (int) (screenHeight * 1 / 100) + 4 * (int) (MenuDimensionY / 6),
					MenuDimensionX - 2 * (int) (screenWidth * 2 / 100), (int) (MenuDimensionY / 6), null);
		}
	}

	private void Init() {

		URL resourceBKImg = getClass().getResource("/images/Age-of-Empires-Menu.jpg");
		try {
			backgroundImg = ImageIO.read(resourceBKImg);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourcePlayButton = getClass().getResource("/images/playButton.png");
		try {
			playButton = ImageIO.read(resourcePlayButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceOptionButton = getClass().getResource("/images/optButton.png");
		try {
			optionsButton = ImageIO.read(resourceOptionButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceInstructionButton = getClass().getResource("/images/instButton.png");
		try {
			instructionButton = ImageIO.read(resourceInstructionButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceHighScoresButton = getClass().getResource("/images/HSButton.png");
		try {
			highScoreButton = ImageIO.read(resourceHighScoresButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceExitButton = getClass().getResource("/images/exitButton.png");
		try {
			exitButton = ImageIO.read(resourceExitButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void changeState() {
		inMenuState = !inMenuState;
	}

}