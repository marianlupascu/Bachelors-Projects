package rotl.store;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;

import javax.imageio.ImageIO;
import javax.swing.JDialog;
import javax.swing.JPanel;

import rotl.entities.SoldierType;
import rotl.player.Player;
import rotl.utilities.Handler;

public class Store extends JPanel {

	private static final long serialVersionUID = 1L;

	private static Store instance = null;
	
	static int currentSoldier = 0;
	static final int numberOfSoldiers = 3;
	private static final ArrayList<String> soldiersSources = new ArrayList<>(
			Arrays.asList("Infantry", "Knight_templar", "Teutonic_knight"));
	private static final ArrayList<String> soldiersName = new ArrayList<>(
			Arrays.asList("Fighter", "Defender", "Warrior"));
	private static ArrayList<Integer> soldiersHealth = new ArrayList<>(
			Arrays.asList(250, 100, 450));
	private static ArrayList<Integer> soldiersArmour = new ArrayList<>(
			Arrays.asList(4, 5, 6));
	private static ArrayList<Integer> soldiersAttack = new ArrayList<>(
			Arrays.asList(30, 35, 88));
	private static ArrayList<Integer> soldiersPurchaseCost = new ArrayList<>(
			Arrays.asList(1000, 1500, 2000));

	private static int closeImgDimensionsX;
	private static int closeImgDimensionsY;
	private static Point closeImgPosition = new Point();

	private static int soldierRectDimensionsX;
	private static int soldierRectDimensionsY;
	private static Point soldierRectPosition = new Point();

	private static int soldierDimensionsX;
	private static int soldierDimensionsY;
	private static Point soldierPosition = new Point();

	private static int prevAndNextButtonDimensionsX;
	private static int prevAndNextButtonDimensionsY;
	private static Point prevButtonPosition = new Point();

	private static int infoRectDimensionsX;
	private static int infoRectDimensionsY;
	private static Point infoRectPosition = new Point();

	private static int buyButtonDimensionsX;
	private static int buyButtonDimensionsY;
	private static Point buyButtonPosition = new Point();

	private static int otherDimensionsX;
	private static int otherDimensionsY;
	private static Point otherPosition = new Point();

	private static Handler handler;
	private static JDialog frame = new JDialog();

	private static int screenWidth, screenHeight;

	private static BufferedImage closeImg;
	private static BufferedImage backgroundImg;
	private static BufferedImage SoldiersBKIMG;

	private static BufferedImage NextButton;
	private static BufferedImage PrevButton;

	private static BufferedImage lifeImg;
	private static BufferedImage damageImg;
	private static BufferedImage attackImg;
	private static BufferedImage costImg;
	private static BufferedImage buyButton;
	private static BufferedImage cashImg;

	public static Store getInstance(Handler handler) {

		if (instance == null) {
			instance = new Store(handler);
		}
		frame.setVisible(true);
		return instance;
	}

	private Store(Handler handler) {

		this.handler = handler;
		
		try {
		SoldiersInfoStore infoStore = new SoldiersInfoStore();
		soldiersHealth = (ArrayList<Integer>) infoStore.getSoldiersHealthInput();
		soldiersArmour = (ArrayList<Integer>) infoStore.getSoldiersArmorInput();
		soldiersAttack = (ArrayList<Integer>) infoStore.getSoldiersAttackInput();
		soldiersPurchaseCost = (ArrayList<Integer>) infoStore.getSoldiersPurchaseCostInput();
		} catch (Exception ex) {
			System.err.println(ex.getMessage());
		}

		// get the parent screen size and get the modal's size
		screenWidth = (handler.getGame().getWidth() * 2) / 3;
		screenHeight = (handler.getGame().getHeight() * 2) / 3;

		closeImgDimensionsX = (int) (screenWidth * 5.5 / 100);
		closeImgDimensionsY = (int) (screenHeight * 9.8 / 100);
		closeImgPosition.setLocation(screenWidth - closeImgDimensionsX, 0);

		soldierRectDimensionsX = (int) (screenWidth * 33 / 100);
		soldierRectDimensionsY = (int) (screenHeight * 68.4 / 100);
		soldierRectPosition.setLocation((int) (screenWidth * 5.5 / 100), (int) (screenHeight * 19 / 100));

		soldierDimensionsX = (int) (screenWidth * 33 / 100);
		soldierDimensionsY = (int) (screenHeight * 61.3 / 100);
		soldierPosition.setLocation((int) (screenWidth * 8.8 / 100), (int) (screenHeight * 24.4 / 100));

		prevAndNextButtonDimensionsX = (int) (screenWidth * 9.7 / 100);
		prevAndNextButtonDimensionsY = (int) (screenHeight * 13.7 / 100);
		prevButtonPosition.setLocation((int) (screenWidth * 11 / 100), soldierRectDimensionsY + soldierRectPosition.y);

		infoRectDimensionsX = (int) (screenWidth * 50 / 100);
		infoRectDimensionsY = soldierRectDimensionsY;
		infoRectPosition.setLocation(soldierRectPosition.x + soldierDimensionsX + (int) (screenWidth * 5.5 / 100),
				soldierRectPosition.y);

		buyButtonDimensionsX = (int) (infoRectDimensionsX * 60 / 100);
		buyButtonDimensionsY = (int) (infoRectDimensionsY * 20 / 100);
		buyButtonPosition.setLocation(infoRectPosition.x + (int) (infoRectDimensionsX * 20 / 100),
				infoRectPosition.y + infoRectDimensionsY - (int) (infoRectDimensionsX * 20 / 100));

		otherDimensionsX = (int) (screenWidth * 4.5 / 100);
		otherDimensionsY = (int) (screenHeight * 7.8 / 100);
		otherPosition.setLocation(infoRectPosition.x + (int) (infoRectDimensionsX * 5 / 100),
				infoRectPosition.y + (int) (screenHeight * 12 / 100));

		setModalSize();

		frame.setUndecorated(true);

		frame.pack();
		frame.setLocationRelativeTo(null);
		frame.setContentPane(this);
		frame.setVisible(true);

		Image image = Toolkit.getDefaultToolkit().getImage(getClass().getResource("/images/cursor_final.png"));
		Point hotspot = new Point(0, 0);
		Cursor cursor = Toolkit.getDefaultToolkit().createCustomCursor(image, hotspot, "pencil");
		frame.setCursor(cursor);
		frame.setAlwaysOnTop(true);

		Init();

		addMouseListener(new MouseAdapter() {

			@Override
			public void mouseClicked(MouseEvent e) {
				if (closeImg != null) {
					Point me = e.getPoint();
					Rectangle bounds = new Rectangle(closeImgPosition.x, closeImgPosition.y, closeImgDimensionsX,
							closeImgDimensionsY);
					if (bounds.contains(me)) {
						frame.setVisible(false);
					}
				}
				if (PrevButton != null) {
					Point me = e.getPoint();
					Rectangle bounds = new Rectangle(prevButtonPosition.x, prevButtonPosition.y,
							prevAndNextButtonDimensionsX, prevAndNextButtonDimensionsY);
					if (bounds.contains(me)) {
						currentSoldier--;
						if (currentSoldier == -1) {
							currentSoldier = numberOfSoldiers - 1;
						}
						URL resourceSoldiersBK = getClass()
								.getResource("/store/" + soldiersSources.get(currentSoldier) + ".png");
						try {
							SoldiersBKIMG = ImageIO.read(resourceSoldiersBK);
						} catch (IOException ex) {
							ex.printStackTrace();
						}
						repaint();
					}
				}
				if (NextButton != null) {
					Point me = e.getPoint();
					Rectangle bounds = new Rectangle(prevButtonPosition.x + prevAndNextButtonDimensionsX + 10,
							prevButtonPosition.y, prevAndNextButtonDimensionsX, prevAndNextButtonDimensionsY);
					if (bounds.contains(me)) {
						currentSoldier++;
						currentSoldier = currentSoldier % numberOfSoldiers;
						URL resourceSoldiersBK = getClass()
								.getResource("/store/" + soldiersSources.get(currentSoldier) + ".png");
						try {
							SoldiersBKIMG = ImageIO.read(resourceSoldiersBK);
						} catch (IOException ex) {
							ex.printStackTrace();
						}
						repaint();
					}
				}
				if (buyButton != null) {
					Point me = e.getPoint();
					Rectangle bounds = new Rectangle(
							buyButtonPosition.x, buyButtonPosition.y, buyButtonDimensionsX,
									buyButtonDimensionsY);
					if (bounds.contains(me)) {
						buy();
					}
				}
			}
		});
	}

	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		g.drawImage(backgroundImg, 0, 0, screenWidth, screenHeight, this);
		g.setFont(new Font("Neuropol X", Font.BOLD, 100));
		g.setColor(Color.WHITE);
		g.drawString("Store", (int) (screenWidth * 40 / 100), 65);
		g.drawImage(closeImg, closeImgPosition.x, closeImgPosition.y, closeImgDimensionsX, closeImgDimensionsY, this);
		g.setColor(new Color(255, 255, 255, 100));
		g.fillRect(soldierRectPosition.x, soldierRectPosition.y, soldierRectDimensionsX, soldierRectDimensionsY);
		g.drawImage(SoldiersBKIMG, soldierPosition.x, soldierPosition.y, soldierDimensionsX, soldierDimensionsY, this);
		g.drawImage(PrevButton, prevButtonPosition.x, prevButtonPosition.y, prevAndNextButtonDimensionsX,
				prevAndNextButtonDimensionsY, this);
		g.drawImage(NextButton, prevButtonPosition.x + prevAndNextButtonDimensionsX + 10, prevButtonPosition.y,
				prevAndNextButtonDimensionsX, prevAndNextButtonDimensionsY, this);
		g.setColor(new Color(255, 255, 255, 100));
		g.fillRect(infoRectPosition.x, infoRectPosition.y, infoRectDimensionsX, infoRectDimensionsY);
		g.drawImage(buyButton,
				buyButtonPosition.x, buyButtonPosition.y, 
				buyButtonDimensionsX, buyButtonDimensionsY,
				this);
		g.drawImage(lifeImg, otherPosition.x, otherPosition.y, otherDimensionsX, otherDimensionsY, this);
		g.drawImage(damageImg, otherPosition.x,
				otherPosition.y + otherDimensionsY + (int) (infoRectDimensionsY * 1 / 100), otherDimensionsX,
				otherDimensionsY, this);
		g.drawImage(attackImg, otherPosition.x,
				otherPosition.y + 2 * otherDimensionsY + 2 * (int) (infoRectDimensionsY * 1 / 100), otherDimensionsX,
				otherDimensionsY, this);
		g.drawImage(costImg, otherPosition.x,
				otherPosition.y + 3 * otherDimensionsY + 3 * (int) (infoRectDimensionsY * 1 / 100), otherDimensionsX,
				otherDimensionsY, this);
		g.setColor(new Color(255, 255, 255));
		g.setFont(new Font("Neuropol", Font.BOLD, 30));
		g.drawString(soldiersName.get(currentSoldier), infoRectPosition.x + (int) (infoRectDimensionsX * 5 / 100),
				infoRectPosition.y + (int) (infoRectDimensionsY * 10 / 100));
		g.setFont(new Font("Neuropol X", Font.BOLD, 30));
		g.drawString("Health: " + soldiersHealth.get(currentSoldier),
				otherPosition.x + otherDimensionsX + (int) (infoRectDimensionsX * 5 / 100),
				otherPosition.y + (int) (infoRectDimensionsY * 7 / 100));
		g.drawString("Armor: " + soldiersArmour.get(currentSoldier),
				otherPosition.x + otherDimensionsX + (int) (infoRectDimensionsX * 5 / 100),
				otherPosition.y + (int) (infoRectDimensionsY * 7 / 100) + otherDimensionsY
						+ (int) (infoRectDimensionsY * 1 / 100));
		g.drawString("Attack: " + soldiersAttack.get(currentSoldier),
				otherPosition.x + otherDimensionsX + (int) (infoRectDimensionsX * 5 / 100),
				otherPosition.y + (int) (infoRectDimensionsY * 7 / 100) + 2 * otherDimensionsY
						+ 2 * (int) (infoRectDimensionsY * 1 / 100));
		g.drawString("Purchase cost: " + soldiersPurchaseCost.get(currentSoldier) + " $",
				otherPosition.x + otherDimensionsX + (int) (infoRectDimensionsX * 5 / 100),
				otherPosition.y + (int) (infoRectDimensionsY * 7 / 100) + 3 * otherDimensionsY
						+ 3 * (int) (infoRectDimensionsY * 1 / 100));
		g.drawImage(cashImg, screenWidth - (int) (screenWidth * 8 / 100),
				screenHeight - (int) (screenHeight * 11 / 100), (int) (screenWidth * 6 / 100),
				(int) (screenHeight * 10 / 100), this);
		g.setFont(new Font("Neuropol X", Font.BOLD, 30));
		g.drawString("100000000 $ : ", (int) (screenWidth * 70 / 100), (int) (screenHeight * 95 / 100));
	}

	private void setModalSize() {

		frame.setPreferredSize(new Dimension(screenWidth, screenHeight));
		frame.setMaximumSize(new Dimension(screenWidth, screenHeight));
		frame.setMinimumSize(new Dimension(screenWidth, screenHeight));
	}

	private void Init() {

		URL resourceBKImg = getClass().getResource("/store/background.jpg");
		try {
			backgroundImg = ImageIO.read(resourceBKImg);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourceCloseImg = getClass().getResource("/store/closeImg.png");
		try {
			closeImg = ImageIO.read(resourceCloseImg);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourceSoldiersBK = getClass().getResource("/store/" + soldiersSources.get(currentSoldier) + ".png");
		try {
			SoldiersBKIMG = ImageIO.read(resourceSoldiersBK);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourcePrevButton = getClass().getResource("/store/TriangleButtonL.png");
		try {
			PrevButton = ImageIO.read(resourcePrevButton);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourceNextButton = getClass().getResource("/store/TriangleButtonR.png");
		try {
			NextButton = ImageIO.read(resourceNextButton);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourcelife = getClass().getResource("/store/heart.png");
		try {
			lifeImg = ImageIO.read(resourcelife);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourcedamage = getClass().getResource("/store/Damage_boost.png");
		try {
			damageImg = ImageIO.read(resourcedamage);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourceattack = getClass().getResource("/store/Attack.png");
		try {
			attackImg = ImageIO.read(resourceattack);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourcecost = getClass().getResource("/store/Gold_pile.png");
		try {
			costImg = ImageIO.read(resourcecost);
		} catch (IOException e) {
			e.printStackTrace();
		}

		URL resourceBuyButton = getClass().getResource("/store/buyButton.png");
		try {
			buyButton = ImageIO.read(resourceBuyButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceMyCash = getClass().getResource("/store/cash-icon.png");
		try {
			cashImg = ImageIO.read(resourceMyCash);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static void updateInformations(ArrayList<Integer> soldiersHealthInput, 
							              ArrayList<Integer> soldiersArmourInput,
							              ArrayList<Integer> soldiersAttackInput,
							              ArrayList<Integer> soldiersUpgradeCostInput,
							              ArrayList<Integer> soldiersPurchaseCostInput) {
		soldiersHealth = soldiersHealthInput;
		soldiersArmour = soldiersArmourInput;
		soldiersAttack = soldiersAttackInput;
		soldiersPurchaseCost = soldiersPurchaseCostInput;
	}

	private void buy() {
		
		final Player player = Player.getInstance();
		SoldierType soldierType = null;
		
		try {
			
			soldierType = SoldierType.values()[Store.currentSoldier];
		
		} catch (IndexOutOfBoundsException ex) {
			
			ex.printStackTrace();
		}
	
		player.addSoldier(soldierType);
	}
}