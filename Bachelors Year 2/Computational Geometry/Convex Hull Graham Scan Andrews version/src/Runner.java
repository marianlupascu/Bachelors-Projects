import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Runner {

    public static void main(String[] args) throws FileNotFoundException {

        //preparing input
        String fileName = "src/data.in";
        File input = new File(fileName);
        Scanner fin = new Scanner(input);

        //input points
        ArrayList<Point> points = new ArrayList<Point>();

        //read
        Double x, y;
        String line = "";

        while (fin.hasNextLine()) {

            line = fin.nextLine();

            line.trim();

            String[] values = line.split(" ");

            x = Double.parseDouble(values[0]);
            y = Double.parseDouble(values[1]);
            points.add(new Point(x, y));
        }

        //solve
        Gfx g = new Gfx();
    }

}
