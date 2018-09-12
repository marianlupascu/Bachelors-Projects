package rotl.player;

import java.util.ArrayList;
import java.util.List;

import javafx.util.Pair;
import rotl.entities.Defender;
import rotl.entities.EntitiesException;
import rotl.entities.Fighter;
import rotl.entities.Soldier;
import rotl.entities.SoldierType;
import rotl.entities.SoldiersInfo;
import rotl.entities.SoldiersInfo.S_Info;
import rotl.entities.Tower;
import rotl.entities.TowersInfo;
import rotl.entities.Warrior;

public class UpgradeUnit implements GameUnit {

	private UpgradeUnit() {
	}

	public static int upgradeEntity(Soldier soldier, UnitOp unit) {

		try {

			if (unit == null)
				unit = UnitOp.FEE;

			if (soldier == null)
				throw new EntitiesException("Invalid soldier !");

			SoldiersInfo sInfo = SoldiersInfo.getInstance();
			S_Info info = null;

			if (soldier instanceof Defender)
				info = sInfo.getSoldierInfo(SoldierType.DEFENDER);
			else if (soldier instanceof Fighter)
				info = sInfo.getSoldierInfo(SoldierType.FIGHTER);
			else if (soldier instanceof Warrior)
				info = sInfo.getSoldierInfo(SoldierType.WARRIOR);

			if (info == null)
				throw new EntitiesException("No soldier info loaded !");

			List<Pair<Integer, Double>> stats = new ArrayList<>();

			stats.add(new Pair<>(info.getBLife(), info.getULife()));
			stats.add(new Pair<>(info.getBArmor(), info.getUArmor()));
			stats.add(new Pair<>(info.getBAttack(), info.getUAttack()));
			stats.add(new Pair<>(info.getBMiss(), info.getUMiss()));
			stats.add(new Pair<>(info.getBDodge(), info.getUDodge()));
			stats.add(new Pair<>(info.getBCritical(), info.getUCritical()));
			stats.add(new Pair<>(info.getBGold(), info.getUGold()));

			int level = soldier.getLevel();

			stats.forEach((pair) -> {

				if (pair.getKey() == SoldiersInfo.ERROR_CODE || pair.getValue() == SoldiersInfo.ERROR_CODE)
					throw new EntitiesException("Invalid soldier info !!");
			});

			List<Integer> newStats = new ArrayList<>();

			stats.forEach((pair) -> {

				int buy = pair.getKey();
				double upgrade = pair.getValue();
				double value = buy * GameUnit.pow(upgrade, level);
				int maxStat = ((value > Integer.MAX_VALUE * 1.0) ? Integer.MAX_VALUE : (int) value);
				newStats.add(maxStat);
			});

			switch (unit) {

			case FEE:
				return newStats.get(newStats.size() - 1);
			case DO:
				soldier.setLevel(level + 1);
				soldier.setLife(newStats.get(0));
				soldier.setArmor(newStats.get(1));
				soldier.setAttack(newStats.get(2));
				soldier.setMissRate(newStats.get(3));
				soldier.setDodgeRate(newStats.get(4));
				soldier.setCriticalRate(newStats.get(5));
				return 0;
			default:
				return 0;
			}

		} catch (Exception ex) {

			ex.printStackTrace();
			return 0;
		}
	}

	public static int upgradeEntity(Tower tower, UnitOp unit) {

		try {

			if (unit == null)
				unit = UnitOp.FEE;

			if (tower == null)
				throw new EntitiesException("Invalid tower !");

			TowersInfo tInfo = TowersInfo.getInstance();

			List<Pair<Integer, Double>> stats = new ArrayList<>();

			stats.add(new Pair<>(tInfo.getBArmor(), tInfo.getUArmor()));
			stats.add(new Pair<>(tInfo.getBAttack(), tInfo.getUAttack()));
			stats.add(new Pair<>(tInfo.getBGold(), tInfo.getUGold()));

			int level = tower.getLevel();

			stats.forEach((pair) -> {

				if (pair.getKey() == TowersInfo.ERROR_CODE || pair.getValue() == TowersInfo.ERROR_CODE)
					throw new EntitiesException("Invalid tower info !!");
			});

			List<Integer> newStats = new ArrayList<>();

			stats.forEach((pair) -> {

				int buy = pair.getKey();
				double upgrade = pair.getValue();
				double value = buy * GameUnit.pow(upgrade, level);
				int maxStat = ((value > Integer.MAX_VALUE * 1.0) ? Integer.MAX_VALUE : (int) value);
				newStats.add(maxStat);
			});

			switch (unit) {

			case FEE:
				return newStats.get(newStats.size() - 1);
			case DO:
				tower.setLevel(level + 1);
				tower.setArmor(newStats.get(0));
				tower.setAttack(newStats.get(1));
				return 0;
			default:
				return 0;
			}

		} catch (Exception ex) {

			ex.printStackTrace();
			return 0;
		}
	}
}
