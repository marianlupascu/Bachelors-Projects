package rotl.store;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import rotl.entities.EntitiesException;
import rotl.entities.SoldierType;
import rotl.entities.SoldiersInfo;
import rotl.entities.SoldiersInfo.S_Info;

public final class SoldiersInfoStore {
	
	private final List<Integer> soldiersHealthInput;
	private final List<Integer> soldiersArmorInput;
	private final List<Integer> soldiersAttackInput;
	private final List<Integer> soldiersPurchaseCostInput;
	
	public SoldiersInfoStore() {
		
		soldiersHealthInput = new ArrayList<>();
		soldiersArmorInput = new ArrayList<>();
		soldiersAttackInput = new ArrayList<>();
		soldiersPurchaseCostInput = new ArrayList<>();
		
		final SoldiersInfo sInfo = SoldiersInfo.getInstance();
		
		Arrays.stream(SoldierType.values()).forEach((soldierType) -> {
			
			final S_Info info = sInfo.getSoldierInfo(soldierType);
			
			if (info == null)
				throw new EntitiesException("No soldier info loaded !");
			
			final int life = info.getBLife();
			final int armor = info.getBArmor();
			final int attack = info.getBAttack();
			final int gold = info.getBGold();
			
			if ((life == SoldiersInfo.ERROR_CODE) || (armor == SoldiersInfo.ERROR_CODE)
					|| (attack == SoldiersInfo.ERROR_CODE) || (gold == SoldiersInfo.ERROR_CODE)) {

				throw new EntitiesException("Invalid soldier info !!");
			}
			
			this.soldiersHealthInput.add(life);
			this.soldiersArmorInput.add(armor);
			this.soldiersAttackInput.add(attack);
			this.soldiersPurchaseCostInput.add(gold);
		});
	}
	
	public List<Integer> getSoldiersHealthInput() {
		
		return this.soldiersHealthInput;
	}
	
	public List<Integer> getSoldiersArmorInput() {
			
			return this.soldiersArmorInput;
		}
	
	public List<Integer> getSoldiersAttackInput() {
		
		return this.soldiersAttackInput;
	}
	
	public List<Integer> getSoldiersPurchaseCostInput() {
		
		return this.soldiersPurchaseCostInput;
	}

}
