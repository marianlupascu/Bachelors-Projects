package rotl.entities;

import rotl.entities.SoldiersInfo.S_Info;

public class SoldierFactory {

	public Soldier getSoldier(SoldierType type) {

		try {

			if (type == null)
				throw new EntitiesException("Invalid soldier type !");

			SoldiersInfo sInfo = SoldiersInfo.getInstance();
			S_Info info = sInfo.getSoldierInfo(type);

			if (info == null)
				throw new EntitiesException("No soldier info loaded !");

			int life = info.getBLife();
			int armor = info.getBArmor();
			int attack = info.getBAttack();
			int missRate = info.getBMiss();
			int dodgeRate = info.getBDodge();
			int criticalRate = info.getBCritical();

			if ((life == SoldiersInfo.ERROR_CODE) || (armor == SoldiersInfo.ERROR_CODE)
					|| (attack == SoldiersInfo.ERROR_CODE) || (missRate == SoldiersInfo.ERROR_CODE)
					|| (dodgeRate == SoldiersInfo.ERROR_CODE) || (criticalRate == SoldiersInfo.ERROR_CODE)) {

				throw new EntitiesException("Invalid soldier info !!");
			}

			switch (type) {

			case DEFENDER:
				return new Defender(life, armor, attack, missRate, dodgeRate, criticalRate);
			case FIGHTER:
				return new Fighter(life, armor, attack, missRate, dodgeRate, criticalRate);
			case WARRIOR:
				return new Warrior(life, armor, attack, missRate, dodgeRate, criticalRate);
			default:
				return null;
			}

		} catch (Exception ex) {

			ex.printStackTrace();
			return null;
		}
	}
}
