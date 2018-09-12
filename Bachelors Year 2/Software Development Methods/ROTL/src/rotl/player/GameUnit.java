package rotl.player;

import rotl.entities.GameEntity;

public interface GameUnit {

	public static double pow(double base, int power) {

		power = Integer.max(power, 0);
		power = Integer.min(GameEntity.MAX_LEVEL - 1, power);

		double res = 1.0;

		for (int i = 0; (1 << i) <= power; i++) {

			if (((1 << i) & power) != 0) {

				res = (res * base);
			}

			base = (base * base);
		}

		return res;
	}
}
