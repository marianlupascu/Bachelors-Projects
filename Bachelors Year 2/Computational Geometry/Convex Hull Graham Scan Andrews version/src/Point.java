import java.util.Comparator;

//Point class
public class Point {

	private Double x; 
	private Double y;
	
	public Point() {};
	
	public Point(final Double x, final Double y) {
		this.x = x;
		this.y = y;
	}
	
	public Double getX() {
		return this.x;
	}
	
	public Double getY() {
		return this.y;
	}
	
	public static Double determinant(final Point a, final Point b, final Point c) {
		return a.x * (b.y - c.y) + b.x * (c.y - a.y) + c.x * (a.y - b.y);
	}
	
	public String forPrint(int offset) {
		return "(" + (this.x - offset) + ", " + (this.y - offset) + ")";
	}
}

//compare: ascending after x, on equality ascending after y
class PointComparator implements Comparator<Point> {

	@Override
	public int compare(Point a, Point b) {

		if (a.getX().compareTo(b.getX()) == 0) {
			 return a.getY().compareTo(b.getY());
		}
	
		return a.getX().compareTo(b.getX());
	}
	
}