package rotl.menu;

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

import javax.imageio.ImageIO;
import javax.swing.JDialog;
import javax.swing.JPanel;

import rotl.utilities.Handler;

public class Instructions extends JPanel implements MenuOption {

	private static final long serialVersionUID = 1L;

	private static int state;

	private static int closeImgDimensionsX;
	private static int closeImgDimensionsY;
	private static Point closeImgPosition = new Point();

	private static int nextButtonDimensionsX;
	private static int nextButtonDimensionsY;
	private static Point nextButtonPosition = new Point();

	private static Handler handler;
	private static JDialog frame = new JDialog();

	private static Instructions single_instance = null;

	private static String content1 = "    Jocul se bazeaza pe ideea de wave;\r\n"
			+ "    - Initial, amandoi jucatorii pornesc doar cu turnurile din baza, toate la\r\n"
			+ "nivelul 1, fara turnuri inafara bazei si fara nici o trupa de soldati;\r\n"
			+ "    - Initial, amandoi jucatorii primesc o cantitate de aur pe baza careia pot\r\n"
			+ "opera asa cum se prezinta in capitolul Store si Player pentru a obtine o\r\n"
			+ "armata mai puternica si o aparare mai buna, si pentru a obtine un scor\r\n"
			+ "cat mai bun intr-un wave;\r\n"
			+ "    - Exista un time standard de pregatire inainte de fiecare lupta, in care\r\n"
			+ "jucatorul isi poate pregati armata;\r\n" + "- Dupa expirarea timpului standard, lupta incepe:\r\n"
			+ "        o Se iau de la fiecare jucator doar trupele pentru care a fost setat\r\n"
			+ "explicit poarta de parasire a bazei si se trimit pe drumul care\r\n" + "pleaca din acea poarta;\r\n"
			+ "        o Trupele se misca prin campul de lupta pe baza unor algoritmi de\r\n"
			+ "decizie in vederea ajungerii la zidul bazei inamice;\r\n"
			+ "        o Pe drum, se pot intalni cu trupe inamice, caz in care se simuleaza\r\n"
			+ "batalia intre ele. Trupa care supravietuieste(daca exista) isi\r\n"
			+ "continua drumul prin campul de lupta;\r\n";
	private static String content2 = "        o Pe drum se pot intalni cu turnuri inamice, caz in care se simuleaza\r\n"
			+ "batalia intre ele. Trupa de soldati isi continua drumul prin campul\r\n"
			+ "de lupta, doar daca a reusit sa distruga turnul (sa elibereze calea);\r\n"
			+ "        o Ajunse la zidul inamic, trupele provoaca daune zidului pana la\r\n"
			+ "caderea acestuia, apoi intra in baza inamica si avanseaza spre\r\n"
			+ "castel; in interior pe fiecare drum va exista cate un turn, care\r\n"
			+ "respecta aceeasi interactiune cu trupele cum este prezentat\r\n" + "anterior;\r\n"
			+ "        o Trupa trecuta si de turnul interior, pe un drum, ajunge la castel,\r\n"
			+ "unde provoaca daune, pana la distrugerea castelului;\r\n"
			+ "        o Distrugerea castelului inamic aduce victoria jucatorului care a\r\n"
			+ "realizat acest lucru;\r\n"
			+ "    - Pentru un wave exista un timp standard; la terminarea timpului pentru\r\n"
			+ "un wave, toate trupele se intorc instant in baza de unde provin si toate\r\n"
			+ "daunele provocate de-a lungul wave-ul terminat se pastreaza, fiind\r\n"
			+ "datoria jucatorului sa isi refaca turnurile si armata; castelul si zidul nu pot\r\n"
			+ "fi refacute !!!\r\n";
	private static String content3 = "    - Dupa terminarea wave-ului (bataliei), se reinstaureaza starea de\r\n"
			+ "pregatire, descrisa anterior;\r\n" + "- Scopul jocului presupune distrugerea castelului inamicului;\r\n"
			+ "    - Nu exista limite pentru numarul de wave-uri, nivelul armatei sau al\r\n"
			+ "turnurilor, totul poate deveni cat de INSANE este posibil !!";

	private static int screenWidth, screenHeight;

	private static BufferedImage backgroundImg;
	private static BufferedImage closeImg;
	private static BufferedImage nextButton;

	private Instructions(Handler handler) {

		this.handler = handler;
		screenWidth = (handler.getGame().getWidth() * 2) / 3;
		screenHeight = (handler.getGame().getHeight() * 2) / 3;

		frame.setPreferredSize(new Dimension(screenWidth, screenHeight));
		frame.setMaximumSize(new Dimension(screenWidth, screenHeight));
		frame.setMinimumSize(new Dimension(screenWidth, screenHeight));

		frame.setUndecorated(true);

		frame.pack();
		frame.setLocationRelativeTo(null);
		frame.setContentPane(this);
		frame.setVisible(true);

		Image image = Toolkit.getDefaultToolkit().getImage(getClass().getResource("/images/cursor_final.png"));
		Point hotspot = new Point(0, 0);
		Cursor cursor = Toolkit.getDefaultToolkit().createCustomCursor(image, hotspot, "pencil");
		frame.setCursor(cursor);

		Init();

		setInstructions();

	}

	public static Instructions getInstructions(Handler handler) {
		if (single_instance == null) {
			single_instance = new Instructions(handler);
		}

		frame.setVisible(true);
		state = 1;

		return single_instance;
	}

	private void drawString(Graphics g, String text, int x, int y) {
		for (String line : text.split("\n"))
			g.drawString(line, x, y += g.getFontMetrics().getHeight());
	}

	@Override
	public void paintComponent(Graphics g) {
		super.paintComponent(g);

		g.drawImage(backgroundImg, 0, 0, screenWidth, screenHeight, this);
		g.setFont(new Font("Neuropol X", Font.BOLD, titleFontSize));
		g.setColor(Color.WHITE);
		g.drawString("Instructions", (int) (screenWidth * 30 / 100), (int) (screenHeight * 15 / 100));
		g.drawImage(closeImg, closeImgPosition.x, closeImgPosition.y, closeImgDimensionsX, closeImgDimensionsY, this);
		g.setFont(new Font("Neuropol X", Font.BOLD, fontSize));
		if (state == 1)
			drawString(g, content1, (int) (screenWidth * 5 / 100), (int) (screenHeight * 25 / 100));
		if (state == 2)
			drawString(g, content2, (int) (screenWidth * 5 / 100), (int) (screenHeight * 25 / 100));
		if (state == 3)
			drawString(g, content3, (int) (screenWidth * 5 / 100), (int) (screenHeight * 25 / 100));
		g.drawImage(nextButton, nextButtonPosition.x, nextButtonPosition.y, nextButtonDimensionsX,
				nextButtonDimensionsY, this);
	}

	public void setInstructions() {

		closeImgDimensionsX = (int) (screenWidth * 5.5 / 100);
		closeImgDimensionsY = (int) (screenHeight * 9.8 / 100);
		closeImgPosition.setLocation(screenWidth - closeImgDimensionsX, 0);

		nextButtonDimensionsX = (int) (screenWidth * 5.5 / 100);
		nextButtonDimensionsY = (int) (screenHeight * 9.8 / 100);
		nextButtonPosition.setLocation(screenWidth - nextButtonDimensionsX - (int) (screenWidth * 1 / 100),
				screenHeight - nextButtonDimensionsY - (int) (screenHeight * 2 / 100));

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
				if (nextButton != null) {
					Point me = e.getPoint();
					Rectangle bounds = new Rectangle(nextButtonPosition.x, nextButtonPosition.y, nextButtonDimensionsX,
							nextButtonDimensionsY);
					if (bounds.contains(me)) {
						if (state != 3) {
							state++;
							repaint();
						}
					}
				}
			}
		});

	}

	@Override
	public void Init() {
		URL resourceBKImg = getClass().getResource("/images/BGinstruction.jpg");
		try {
			backgroundImg = ImageIO.read(resourceBKImg);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceCloseImg = getClass().getResource("/images/closeImg.png");
		try {
			closeImg = ImageIO.read(resourceCloseImg);
		} catch (IOException e) {
			e.printStackTrace();
		}
		URL resourceNextButton = getClass().getResource("/images/Next.png");
		try {
			nextButton = ImageIO.read(resourceNextButton);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}