import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;

import javafx.util.Pair;

//Convex Hull determined using "Graham's scan, Andrew's variant"
public class ConvexHull {

    private ArrayList<Point> hull; //points on the hull
    private ArrayList<Pair<Pair<Point, Point>, Boolean>> upperEnvelope; //segmentele ce trebuiesc desenate true = apartine lui hull false altfel
    private ArrayList<Pair<Pair<Point, Point>, Boolean>> lowerEnvelope;

    public ConvexHull(ArrayList<Point> points) {

        this.hull = new ArrayList<Point>();
        this.upperEnvelope = new ArrayList<Pair<Pair<Point, Point>, Boolean>>();
        this.lowerEnvelope = new ArrayList<Pair<Pair<Point, Point>, Boolean>>();

        Collections.sort(points, new PointComparator());

        Point[] hull = new Point[2 * points.size()];
        Pair<Pair<Point, Point>, Boolean>[] upperEnvelope;
        Pair<Pair<Point, Point>, Boolean>[] lowerEnvelope;
        upperEnvelope = new Pair[2 * points.size()];
        lowerEnvelope = new Pair[2 * points.size()];

        //computing upper envelope
        Integer L = -1;
        Integer Up = 0, Lo = 0;
        for (Integer i = 0; i < points.size(); ++i) {
            while (L > 0 && Point.determinant(hull[L - 1], hull[L], points.get(i)) < 0) {
                upperEnvelope[Up++] = new Pair<Pair<Point, Point>, Boolean>(new Pair<Point, Point>(hull[L - 1], hull[L]), false);
                L--;
            }

            hull[++L] = points.get(i);
            if (L > 0)
                upperEnvelope[Up++] = new Pair<Pair<Point, Point>, Boolean>(new Pair<Point, Point>(hull[L - 1], hull[L]), true);
        }
        upperEnvelope[Up++] = new Pair<Pair<Point, Point>, Boolean>(new Pair<Point, Point>(hull[L], points.get(points.size() - 1)), true);
        Integer l = L;
        L--;
        System.out.print(L + "    ");

        //computing lower envelope
        for (Integer i = points.size() - 1; i >= 0; --i) {
            while (L > l && Point.determinant(hull[L - 1], hull[L], points.get(i)) < 0) {
                lowerEnvelope[Lo++] = new Pair<Pair<Point, Point>, Boolean>(new Pair<Point, Point>(hull[L - 1], hull[L]), false);
                L--;
            }

            hull[++L] = points.get(i);
            if (L > 0)
                lowerEnvelope[Lo++] = new Pair<Pair<Point, Point>, Boolean>(new Pair<Point, Point>(hull[L - 1], hull[L]), true);
        }

        lowerEnvelope[Lo++] = new Pair<Pair<Point, Point>, Boolean>(new Pair<Point, Point>(hull[L], points.get(0)), true);

        for (Integer i = 0; i < L; ++i) {
            this.hull.add(hull[i]);
        }
        for (Integer i = 0; i < Up; ++i) {
            this.upperEnvelope.add(upperEnvelope[i]);
        }
        for (Integer i = 0; i < Lo; ++i) {
            this.lowerEnvelope.add(lowerEnvelope[i]);
        }
    }

    public ArrayList<Point> getHull() {
        return hull;
    }

    public ArrayList<Pair<Pair<Point, Point>, Boolean>> getUpperEnvelope() {
        return upperEnvelope;
    }

    public ArrayList<Pair<Pair<Point, Point>, Boolean>> getLowerEnvelope() {
        return lowerEnvelope;
    }

    public void print(String outFile, int offset) throws FileNotFoundException {

        PrintWriter out = new PrintWriter(outFile);

        for (Point point : hull) {
            out.println(point.forPrint(offset));
        }

        out.close();
    }

}
