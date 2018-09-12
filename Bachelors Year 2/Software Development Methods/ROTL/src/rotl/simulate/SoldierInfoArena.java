package rotl.simulate;

public final class SoldierInfoArena {
	
	 private final int life;
	 private final int armor;
	 private final int attack;
	 private final int gold;
	 
	 private SoldierInfoArena(int life, int armor, int attack, int gold) {
		 
		 this.life = life;
		 this.armor = armor;
		 this.attack = attack;
		 this.gold = gold;
	 }
	 
	 public int getLife() {
		 return this.life;
	 }
	 
	 public int getArmor() {
		 return this.armor;
	 }
	 
	 public int getAttack() {
		 return this.attack;
	 }
	 
	 public int getGold() {
		 return this.gold;
	 }
	 
	 public static Builder builder() {
		 return new Builder();
	 }
	 
	 public static final class Builder {
		 
		 private int life;
		 private int armor;
		 private int attack;
		 private int gold;
		 
		 private Builder() {}
		 
		 public Builder withLife(int life) {
			 this.life = life;
			 return this;
		 }
		 
		 public Builder withArmor(int armor) {
			 this.armor = armor;
			 return this;
		 }
		 
		 public Builder withAttack(int attack) {
			 this.attack = attack;
			 return this;
		 }
		 
		 public Builder withGold(int gold) {
			 this.gold = gold;
			 return this;
		 }
		 
		 public SoldierInfoArena build() {
			 return new SoldierInfoArena(life, armor, attack, gold);
		 }
	 }
}
