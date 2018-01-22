import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.FileNotFoundException;
import java.util.ArrayList;

import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.Timer;

import javafx.util.Pair;

public class Gfx extends JPanel {

    private JFrame frame;
    private JButton start, clear;

    private Timer timer = null;

    private final int SCREEN_WIDTH = 720, SCREEN_HEIGHT = 630;
    private final int AXIS_WIDTH = 700, AXIS_HEIGHT = 500;
    private final int RADIUS = 5;

    private ArrayList<Point> points = new ArrayList<Point>();
    private ArrayList<Point> result = new ArrayList<Point>();
    private ArrayList<Pair<Pair<Point, Point>, Boolean>> upperEnvelope = new ArrayList<Pair<Pair<Point, Point>, Boolean>>();
    private ArrayList<Pair<Pair<Point, Point>, Boolean>> lowerEnvelope = new ArrayList<Pair<Pair<Point, Point>, Boolean>>();

    private int index, upperEnvelopeindex, lowerEnvelopeindex;

    public Gfx() {

        frame = new JFrame("Acoperire convexa");
        start = new JButton("Start");
        clear = new JButton("Clear");

        //initialize the screen
        frame.setLocation(200, 50);
        frame.setSize(SCREEN_WIDTH, SCREEN_HEIGHT);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.add(this);
        this.addMouseListener(new MouseListener() {

            @Override
            public void mouseClicked(MouseEvent e) {

                double x = e.getPoint().x;
                double y = e.getPoint().y;
                System.out.println((x - 250) + " " + (250 - y));

                //if the click is inside the axis
                if (x < AXIS_WIDTH && y < AXIS_HEIGHT) {
                    points.add(new Point(x, y));
                    index = 0;
                    upperEnvelopeindex = 0;
                    lowerEnvelopeindex = 0;
                    if (timer != null)
                        if (timer.isRunning())
                            timer.stop();
                    repaint();
                }
            }

            @Override
            public void mouseEntered(MouseEvent e) {
            }

            @Override
            public void mouseExited(MouseEvent e) {
                // TODO Auto-generated method stub

            }

            @Override
            public void mousePressed(MouseEvent e) {
                // TODO Auto-generated method stub

            }

            @Override
            public void mouseReleased(MouseEvent e) {
                // TODO Auto-generated method stub

            }
        });

        this.setLayout(new BoxLayout(this, BoxLayout.PAGE_AXIS));
        this.add(Box.createVerticalStrut(AXIS_HEIGHT + 10));

        //initialize start button
        start.setMinimumSize(new Dimension(100, 25));
        start.setMaximumSize(new Dimension(100, 40));
        start.setPreferredSize(new Dimension(100, 30));
        this.add(start);
        start.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent arg0) {

                //disable buttons while drawing
                start.setEnabled(false);
                clear.setEnabled(false);

                //get the result
                ConvexHull hull = new ConvexHull(points);
                result = hull.getHull();
                upperEnvelope = hull.getUpperEnvelope();
                lowerEnvelope = hull.getLowerEnvelope();
                if (result.size() == 0)
                    return;
                //add the first point in order to close the convex hull
                result.add(result.get(0));

                int delay = 1000;
                int len = result.size();
                index = 0;
                upperEnvelopeindex = 0;
                lowerEnvelopeindex = 0;

                ActionListener draw = new ActionListener() {
                    @Override
                    public void actionPerformed(ActionEvent e) {
                        ++index;
                        ++upperEnvelopeindex;
                        //if we reach the last point we stop the drawing
                        if (upperEnvelopeindex >= upperEnvelope.size()) {
                            ++lowerEnvelopeindex;
                            if (lowerEnvelopeindex == lowerEnvelope.size()) {
                                timer.stop();
                                start.setEnabled(true);
                                clear.setEnabled(true);
                                return;
                            }
                        }
                        //else we repaint the screen
                        repaint();
                        //draw the convex-hull`s elements step by step
                    }
                };

                //initialize and start the timer
                timer = new Timer(delay, draw);
                timer.start();

                try {
                    hull.print("src/data.out", 250);
                } catch (FileNotFoundException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        });

        //initialize clear button
        clear.setMinimumSize(new Dimension(100, 25));
        clear.setMaximumSize(new Dimension(100, 40));
        clear.setPreferredSize(new Dimension(100, 30));
        this.add(clear);
        clear.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {

                //clear the arrays and the screen
                points.clear();
                result.clear();
                index = 0;
                repaint();
            }
        });

        frame.setVisible(true);
    }

    public void paintComponent(Graphics g) {

        super.paintComponent(g);

        int len = points.size();
        g.fillRect(0, 0, this.getWidth(), this.getHeight());
        g.setColor(Color.white);
        g.fillRect(1, 1, AXIS_WIDTH, AXIS_HEIGHT);
        g.setColor(Color.black);
        //draw the axis
        g.drawLine(AXIS_WIDTH / 2, 0, AXIS_WIDTH / 2, AXIS_HEIGHT);
        g.drawLine(0, AXIS_HEIGHT / 2, AXIS_WIDTH, AXIS_HEIGHT / 2);
        //draw top of axles
        g.drawLine(AXIS_WIDTH / 2 - 7, 10, AXIS_WIDTH / 2, 0);
        g.drawLine(AXIS_WIDTH / 2 + 7, 10, AXIS_WIDTH / 2, 0);
        g.drawLine(AXIS_WIDTH - 10, AXIS_HEIGHT / 2 + 7, AXIS_WIDTH, AXIS_HEIGHT / 2);
        g.drawLine(AXIS_WIDTH - 10, AXIS_HEIGHT / 2 - 7, AXIS_WIDTH, AXIS_HEIGHT / 2);
        g.drawLine(AXIS_WIDTH / 2 + 7, 10, AXIS_WIDTH / 2, 0);
        g.drawRect(1, 1, AXIS_WIDTH, AXIS_HEIGHT);

        //draw all the points
        for (int i = 0; i < len; ++i)
            g.drawOval((points.get(i).getX()).intValue() - RADIUS / 2, (points.get(i).getY()).intValue() - RADIUS / 2, RADIUS, RADIUS);

        for (int i = 0; i < ((upperEnvelopeindex >= upperEnvelope.size()) ? upperEnvelope.size() : upperEnvelopeindex); i++) {
            if (!upperEnvelope.get(i).getValue())
                g.setColor(Color.red);
            else
                g.setColor(Color.green);
            g.drawLine((upperEnvelope.get(i).getKey().getKey().getX()).intValue(), (upperEnvelope.get(i).getKey().getKey().getY()).intValue(),
                    (upperEnvelope.get(i).getKey().getValue().getX()).intValue(), (upperEnvelope.get(i).getKey().getValue().getY()).intValue());
        }
        for (int i = 0; i < lowerEnvelopeindex; i++) {
            if (!lowerEnvelope.get(i).getValue())
                g.setColor(Color.pink);
            else
                g.setColor(Color.blue);
            g.drawLine((lowerEnvelope.get(i).getKey().getKey().getX()).intValue(), (lowerEnvelope.get(i).getKey().getKey().getY()).intValue(),
                    (lowerEnvelope.get(i).getKey().getValue().getX()).intValue(), (lowerEnvelope.get(i).getKey().getValue().getY()).intValue());
        }
        if (upperEnvelopeindex >= upperEnvelope.size())
            for (int i = upperEnvelope.size() - 1; i > ((upperEnvelope.size() - 3 < 0) ? (1) : (upperEnvelope.size() - 3)); i--) {
                if (!upperEnvelope.get(i).getValue())
                    g.setColor(Color.red);
                else
                    g.setColor(Color.green);
                g.drawLine((upperEnvelope.get(i).getKey().getKey().getX()).intValue(), (upperEnvelope.get(i).getKey().getKey().getY()).intValue(),
                        (upperEnvelope.get(i).getKey().getValue().getX()).intValue(), (upperEnvelope.get(i).getKey().getValue().getY()).intValue());
            }
/*      g.setColor(Color.green);
        for(int i = 0;i < index; ++i) {
            g.drawLine((result.get(i).getX()).intValue(), (result.get(i).getY()).intValue(),
                    (result.get(i + 1).getX()).intValue(), (result.get(i + 1).getY()).intValue());
        }
*/
    }
}