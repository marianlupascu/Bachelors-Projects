package rotl.player;

import java.util.ArrayList;
import java.util.List;

import rotl.entities.EntitiesException;
import rotl.entities.Soldier;
import rotl.entities.SoldierFactory;
import rotl.entities.SoldierType;
import rotl.simulate.SoldierInfoArena;

public class Player {

	private static final int GOLD = 100000000;
	private static Player _player = null;

	private Player() {
		this.gold = GOLD;
	}

	public static Player getInstance() {

		if (_player == null)
			_player = new Player();

		return _player;
	}
	
	private int gold;
	private final SoldierFactory soldierFactory = new SoldierFactory();
	private final List<Soldier> soldiers = new ArrayList<>();
	
	public int getNumberOfSoldiers() {
		
		return soldiers.size();
	}
	
	public SoldierInfoArena getSoldierInfo(int index) {
		
		if (index < 0 || index >= soldiers.size())
			throw new IllegalArgumentException();
		
		final Soldier soldier = soldiers.get(index);
		
		final SoldierInfoArena.Builder builder = SoldierInfoArena.builder();
		
		builder.withLife(soldier.getLife())
				.withArmor(soldier.getArmor())
				.withAttack(soldier.getAttack())
				.withGold(UpgradeUnit.upgradeEntity(soldier, UnitOp.FEE));
		
		return builder.build();
	}
	
	public void addSoldier(SoldierType soldierType) {
		
		try {
			
			final Soldier soldier = this.soldierFactory.getSoldier(soldierType);
			soldiers.add(soldier);
		
		} catch (EntitiesException ex) {
			
			ex.printStackTrace();
		}
	}
	
	public void removeSoldier(int index) {
		
		if (index < 0 || index >= soldiers.size())
			throw new IllegalArgumentException();
		
		soldiers.remove(index);
	}
	
	public void upgradeSoldier(int index) {
		
		if (index < 0 || index >= soldiers.size())
			throw new IllegalArgumentException();
		
		final Soldier soldier = soldiers.get(index);
		
		/** Pay money for upgrade **/
		
		// int upgradeGold = UpgradeUnit.upgradeEntity(soldier, UnitOp.FEE);
		
		//if (this.gold >= upgradeGold) {
			
			UpgradeUnit.upgradeEntity(soldier, UnitOp.DO);
			
			//this.gold -= upgradeGold;
		//}
	}
	
	public void healSoldier(int index) {
		
		if (index < 0 || index >= soldiers.size())
			throw new IllegalArgumentException();
		
		final Soldier soldier = soldiers.get(index);
		
		/** Pay money for upgrade **/
		
		//int healGold = RepairUnit.healSoldier(soldier, UnitOp.FEE);
		
		//if (this.gold >= healGold) {
			
			RepairUnit.healSoldier(soldier, UnitOp.DO);
			
			//this.gold -= healGold;
		//}
	}
	
	public void repairArmorSoldier(int index) {
		
		if (index < 0 || index >= soldiers.size())
			throw new IllegalArgumentException();
		
		final Soldier soldier = soldiers.get(index);
		
		/** Pay money for upgrade **/
		
		//int repairGold = RepairUnit.repairArmor(soldier, UnitOp.FEE);
		
		//if (this.gold >= repairGold) {
			
			RepairUnit.repairArmor(soldier, UnitOp.DO);
			
			//this.gold -= repairGold;
		//}
	}
	
	/** Getters **/

	public int getGold() {

		return this.gold;
	}

	/** Setters **/

	public void setGold(int _gold) {

		_gold = Integer.max(_gold, 0);
		this.gold = _gold;
	}
}
