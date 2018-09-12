package rotl.entities;

public class TowerFactory {

	public Tower getTower() {

		try {

			TowersInfo tInfo = TowersInfo.getInstance();

			int armor = tInfo.getBArmor();
			int attack = tInfo.getBAttack();

			if ((armor == TowersInfo.ERROR_CODE) || (attack == TowersInfo.ERROR_CODE)) {

				throw new EntitiesException("Invalid tower info !!");
			}

			return new Tower(armor, attack);

		} catch (Exception ex) {

			ex.printStackTrace();
			return null;
		}
	}
}
