package rotl.entities;

public abstract class Soldier implements GameEntity {

	private int level;
	protected int life;
	protected int armor;
	protected int attack;

	protected int missRate;
	protected int dodgeRate;
	protected int criticalRate;

	/** Constructors **/
	public Soldier(int _life, int _armor, int _attack, int _miss, int _dodge, int _critical) {

		this.level = 1;
		this.setLife(_life);
		this.setArmor(_armor);
		this.setAttack(_attack);
		this.setMissRate(_miss);
		this.setDodgeRate(_dodge);
		this.setCriticalRate(_critical);
	}

	public Soldier() {

		this(0, 0, 0, 0, 0, 0);
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

	/** Life **/
	public int getLife() {

		return this.life;
	}

	public void setLife(int _life) {

		_life = Integer.max(_life, 0);
		this.life = _life;
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

	/** Miss rate **/
	public int getMissRate() {

		return this.missRate;
	}

	public void setMissRate(int _miss) {

		_miss = Integer.max(_miss, 0);
		_miss = Integer.min(_miss, 100);
		this.missRate = _miss;
	}

	/** Dodge rate **/
	public int getDodgeRate() {

		return this.dodgeRate;
	}

	public void setDodgeRate(int _dodge) {

		_dodge = Integer.max(_dodge, 0);
		_dodge = Integer.min(_dodge, 40);
		this.dodgeRate = _dodge;
	}

	/** Critical Rate **/
	public int getCriticalRate() {

		return this.criticalRate;
	}

	public void setCriticalRate(int _critical) {

		_critical = Integer.max(_critical, 0);
		_critical = Integer.min(_critical, 100);
		this.criticalRate = _critical;
	}

	@Override
	public boolean isDead() {

		return (this.life == 0);
	}

	/**
	 * TODO
	 * 
	 * Object.equals() Object.hashCode() Object.clone() in case of ID implementation
	 */
}
