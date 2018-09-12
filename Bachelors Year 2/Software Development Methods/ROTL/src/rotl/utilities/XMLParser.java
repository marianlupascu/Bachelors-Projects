package rotl.utilities;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import rotl.entities.SoldierType;
import rotl.entities.SoldiersInfo;
import rotl.entities.SoldiersInfo.S_Info;
import rotl.entities.TowersInfo;

public class XMLParser {

	private static S_Info getSoldierInfo(Element node) {

		S_Info info = new S_Info();

		try {

			Element buy = (Element) node.getElementsByTagName("buy").item(0);
			Element upgrade = (Element) node.getElementsByTagName("upgrade").item(0);

			String[] attributes = { "life", "armor", "attack", "gold", "miss", "dodge", "critical" };

			/** Buy **/
			List<Integer> bStatus = new ArrayList<>();
			List<Double> uStatus = new ArrayList<>();

			for (String attr : attributes)
				bStatus.add(Integer.parseInt(buy.getElementsByTagName(attr).item(0).getTextContent().trim()));

			info.setBLife(bStatus.get(0));
			info.setBArmor(bStatus.get(1));
			info.setBAttack(bStatus.get(2));
			info.setBGold(bStatus.get(3));
			info.setBMiss(bStatus.get(4));
			info.setBDodge(bStatus.get(5));
			info.setBCritical(bStatus.get(6));

			/** Upgrade **/

			for (String attr : attributes)
				uStatus.add(Double.parseDouble(upgrade.getElementsByTagName(attr).item(0).getTextContent().trim()));

			info.setULife(uStatus.get(0));
			info.setUArmor(uStatus.get(1));
			info.setUAttack(uStatus.get(2));
			info.setUGold(uStatus.get(3));
			info.setUMiss(uStatus.get(4));
			info.setUDodge(uStatus.get(5));
			info.setUCritical(uStatus.get(6));

		} catch (Exception ex) {

			System.err.println("Wrong Soldiers XML format !!!");
			ex.printStackTrace();
			return null;
		}

		return info;
	}

	private static void parseTypes(Node sTypes) {

		NodeList list = sTypes.getChildNodes();
		SoldiersInfo sInfo = SoldiersInfo.getInstance();

		for (int i = 0; i < list.getLength(); i++) {

			Node node = list.item(i);

			if (node.getNodeType() == Node.ELEMENT_NODE) {

				S_Info info = getSoldierInfo((Element) node);

				if (info != null) {

					switch (node.getNodeName()) {

					case "defender":
						sInfo.addSoldierInfo(SoldierType.DEFENDER, info);
						break;
					case "fighter":
						sInfo.addSoldierInfo(SoldierType.FIGHTER, info);
						break;
					case "warrior":
						sInfo.addSoldierInfo(SoldierType.WARRIOR, info);
						break;
					default:
						break;
					}
				}
			}
		}
	}

	public static void parseSoldiersInfo(String path) {

		try {

			File inputFile = new File(path);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(inputFile);
			doc.getDocumentElement().normalize();

			Element root = doc.getDocumentElement();
			NodeList list = root.getChildNodes();

			for (int i = 0; i < list.getLength(); i++) {

				Node node = list.item(i);

				if (node.getNodeType() == Node.ELEMENT_NODE) {

					switch (node.getNodeName()) {

					case "types":
						parseTypes(node);
						break;
					default:
						break;
					}
				}
			}

		} catch (Exception ex) {

			System.err.println("Soldiers XML parsing error !!!");
			ex.printStackTrace();
		}
	}

	private static void addTowersInfo(Element node) {

		TowersInfo tInfo = TowersInfo.getInstance();

		try {

			Element buy = (Element) node.getElementsByTagName("buy").item(0);
			Element upgrade = (Element) node.getElementsByTagName("upgrade").item(0);

			String[] attributes = { "armor", "attack", "gold" };

			/** Buy **/
			List<Integer> bStatus = new ArrayList<>();
			List<Double> uStatus = new ArrayList<>();

			/** Buy **/
			for (String attr : attributes)
				bStatus.add(Integer.parseInt(buy.getElementsByTagName(attr).item(0).getTextContent().trim()));

			tInfo.setBArmor(bStatus.get(0));
			tInfo.setBAttack(bStatus.get(1));
			tInfo.setBGold(bStatus.get(2));

			/** Upgrade **/

			for (String attr : attributes)
				uStatus.add(Double.parseDouble(upgrade.getElementsByTagName(attr).item(0).getTextContent().trim()));

			tInfo.setUArmor(uStatus.get(0));
			tInfo.setUAttack(uStatus.get(1));
			tInfo.setUGold(uStatus.get(2));

		} catch (Exception ex) {

			System.err.println("Wrong Towers XML format !!!");
			ex.printStackTrace();
		}
	}

	public static void parseTowersInfo(String path) {

		try {

			File inputFile = new File(path);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(inputFile);
			doc.getDocumentElement().normalize();

			Element root = doc.getDocumentElement();
			addTowersInfo(root);

		} catch (Exception ex) {

			System.err.println("Towers XML parsing error !!!");
			ex.printStackTrace();
		}
	}
}
