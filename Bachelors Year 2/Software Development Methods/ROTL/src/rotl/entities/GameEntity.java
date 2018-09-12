package rotl.entities;

public interface GameEntity {

	int MAX_LEVEL = 50;

	int dealDamage();

	void takeDamage(int damage);

	boolean isDead();
}
