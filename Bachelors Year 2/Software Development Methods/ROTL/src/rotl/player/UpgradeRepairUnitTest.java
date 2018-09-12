package rotl.player;

import rotl.entities.GameEntity;
import rotl.entities.Soldier;
import rotl.entities.SoldierFactory;
import rotl.entities.SoldierType;
import rotl.entities.Tower;
import rotl.entities.TowerFactory;
import rotl.utilities.XMLParser;

public class UpgradeRepairUnitTest {

	public static void main(String[] args) {

		String soldiersPath = "resources\\entities_info\\soldiers.xml";
		String towersPath = "resources\\entities_info\\towers.xml";
		XMLParser.parseSoldiersInfo(soldiersPath);
		XMLParser.parseTowersInfo(towersPath);

		SoldierFactory sf = new SoldierFactory();
		TowerFactory tf = new TowerFactory();

		Soldier s = sf.getSoldier(SoldierType.WARRIOR);
		
		System.out.println("Soldier");
		System.out.println();
		System.out.println("Before");
		System.out.println("Life: " + s.getLife());
		System.out.println("Armor: " + s.getArmor());
		System.out.println("Attack: " + s.getAttack());
		System.out.println("MissRate: " + s.getMissRate());
		System.out.println("DodgeRate: " + s.getDodgeRate());
		System.out.println("CriticalRate: " + s.getCriticalRate());
		System.out.println("Level: " + s.getLevel());

		UpgradeUnit.upgradeEntity(s, UnitOp.DO);

		System.out.println();
		System.out.println("After");
		System.out.println("Life: " + s.getLife());
		System.out.println("Armor: " + s.getArmor());
		System.out.println("Attack: " + s.getAttack());
		System.out.println("MissRate: " + s.getMissRate());
		System.out.println("DodgeRate: " + s.getDodgeRate());
		System.out.println("CriticalRate: " + s.getCriticalRate());
		System.out.println("Level: " + s.getLevel());
		
		/*Tower t = tf.getTower();

		System.out.println("Soldier");
		System.out.println();
		System.out.println("Before");
		System.out.println("Life: " + s.getLife());
		System.out.println("Armor: " + s.getArmor());
		System.out.println("Attack: " + s.getAttack());
		System.out.println("MissRate: " + s.getMissRate());
		System.out.println("DodgeRate: " + s.getDodgeRate());
		System.out.println("CriticalRate: " + s.getCriticalRate());
		System.out.println("Level: " + s.getLevel());

		for (int i = 1; i <= GameEntity.MAX_LEVEL - 1; i++)
			UpgradeUnit.upgradeEntity(s, UnitOp.DO);

		System.out.println();
		System.out.println("After");
		System.out.println("Life: " + s.getLife());
		System.out.println("Armor: " + s.getArmor());
		System.out.println("Attack: " + s.getAttack());
		System.out.println("MissRate: " + s.getMissRate());
		System.out.println("DodgeRate: " + s.getDodgeRate());
		System.out.println("CriticalRate: " + s.getCriticalRate());
		System.out.println("Level: " + s.getLevel());

		int goldLife = RepairUnit.healSoldier(s, UnitOp.FEE);
		int goldArmor = RepairUnit.repairArmor(s, UnitOp.FEE);

		System.out.println();
		System.out.println("Gold life heal : " + goldLife);
		System.out.println("Gold armor repair: " + goldArmor);
		System.out.println();

		System.out.println("Tower");
		System.out.println();
		System.out.println("Before");
		System.out.println("Armor: " + t.getArmor());
		System.out.println("Attack: " + t.getAttack());
		System.out.println("Level: " + t.getLevel());

		for (int i = 1; i <= GameEntity.MAX_LEVEL - 1; i++)
			UpgradeUnit.upgradeEntity(t, UnitOp.DO);

		System.out.println();
		System.out.println("After");
		System.out.println("Armor: " + t.getArmor());
		System.out.println("Attack: " + t.getAttack());
		System.out.println("Level: " + t.getLevel());

		goldArmor = RepairUnit.repairArmor(t, UnitOp.FEE);

		System.out.println("Gold armor repair: " + goldArmor);*/
	}

}
