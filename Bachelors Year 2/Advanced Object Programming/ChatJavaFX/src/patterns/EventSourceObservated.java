package patterns;

import controllers.ControllerForLoginClient;
import javafx.scene.input.MouseEvent;

import java.util.Objects;
import java.util.Observable;

public class EventSourceObservated extends Observable {

    ControllerForLoginClient controllerForLoginClient;

    public EventSourceObservated(ControllerForLoginClient controller) {
        super();
        controllerForLoginClient = controller;
    }

    public void start() {

        controllerForLoginClient.getActualHostName().addEventHandler(MouseEvent.MOUSE_EXITED, event -> {
            String selected = (String) controllerForLoginClient.getActualHostName().getText().trim();
            if (!Objects.equals("localhost", selected)) {
                setChanged();
                notifyObservers(selected);
            }
        });
        controllerForLoginClient.getActualHostName().addEventHandler(MouseEvent.MOUSE_PRESSED, event -> {
            String selected = (String) controllerForLoginClient.getActualHostName().getText().trim();
            if (!Objects.equals("localhost", selected)) {
                setChanged();
                notifyObservers(selected);
            }
        });
    }
}