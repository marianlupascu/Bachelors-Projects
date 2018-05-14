package patterns;

import javafx.stage.Stage;

public class ProxyImage implements ImageInterface {

    private RealImage image = null;
    private String filename = null;

    public ProxyImage(final String filename) {
        this.filename = filename;
    }

    public void displayImage(Stage primaryStage) {
        if (image == null) {
            image = new RealImage(filename);
        }
        image.displayImage(primaryStage);
    }
}
