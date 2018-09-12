package rotl.entities;

public class Tower implements GameEntity {

	private int level;
	private int armor;
	private int attack;

	public Tower(int _armor, int _attack) {

		this.level = 1;
		this.setArmor(_armor);
		this.setAttack(_attack);
	}

	public Tower() {

		this(0, 0);
	}

	/** Level **/
	public int getLevel() {

		return this.level;
	}

	public void setLevel(int _level) {

		_level = Integer.max(_level, 1);
		_level = Integer.min(_level, GameEntity.MAX_LEVEL);
		this.level = _level;
	}

	/** Armor **/
	public int getArmor() {

		return this.armor;
	}

	public void setArmor(int _armor) {

		_armor = Integer.max(_armor, 0);
		this.armor = _armor;
	}

	/** Attack **/
	public int getAttack() {

		return this.attack;
	}

	public void setAttack(int _attack) {

		_attack = Integer.max(_attack, 0);
		this.attack = _attack;
	}

	@Override
	public boolean isDead() {

		return (this.armor == 0);
	}

	@Override
	public void takeDamage(int damage) {

		if (!this.isDead()) {

			int remainedArmor = Integer.max(this.armor - damage, 0);

			this.setArmor(remainedArmor);
		}
	}

	@Override
	public int dealDamage() {

		if (!this.isDead())
			return this.attack;

		return 0;
	}
}
