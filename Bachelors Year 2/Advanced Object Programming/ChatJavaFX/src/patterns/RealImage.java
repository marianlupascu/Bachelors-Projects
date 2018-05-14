package patterns;

import javafx.scene.image.Image;
import javafx.stage.Stage;


public class RealImage {

    Image applicationIcon = null;
    private String filename = null;

    public RealImage(final String filename) {
        this.filename = filename;
        loadImageFromDisk();
    }

    private void loadImageFromDisk() {
        applicationIcon = new Image(getClass().getResourceAsStream(filename));
    }


    public void displayImage(Stage primaryStage) {
        primaryStage.getIcons().add(applicationIcon);
    }

}
