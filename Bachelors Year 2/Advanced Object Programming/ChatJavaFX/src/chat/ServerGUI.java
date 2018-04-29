package chat;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import controllers.ControllerForServerGUI;
import java.lang.String;
import javafx.event.EventHandler;
import javafx.stage.WindowEvent;


public class ServerGUI extends Application {

    private Server server;

    private ControllerForServerGUI controllerServer;

    @Override
    public void start(Stage primaryStage) throws Exception {

        try{
        FXMLLoader loader = new FXMLLoader(getClass().getResource("../resources/xml/ServerGUI_css.fxml"));

        controllerServer = new ControllerForServerGUI(this);
        // Set it in the FXMLLoader
        loader.setController(controllerServer);

        Parent root = (Parent) loader.load();
        Image applicationIcon = new Image(getClass().getResourceAsStream("../resources/img/favicon.png"));
        primaryStage.getIcons().add(applicationIcon);
        primaryStage.setTitle("SpaceChat - ServerGUI");
        primaryStage.setScene(new Scene(root));
        primaryStage.show();

            primaryStage.setOnCloseRequest(new EventHandler<WindowEvent>() {
                @Override
                public void handle(WindowEvent event) {
                    // if my Server exist
                    if (server != null) {
                        try {
                            server.stop();            // ask the server to close the conection
                        } catch (Exception eClose) {
                        }
                        server = null;
                     }
                    try {
                        stop();
                    }catch (Exception e) {}
                }
            });

        } catch (Exception e) {
            e.printStackTrace();
        }

        server = null;
    }

    public static void main(String[] args) {
        launch(args);
    }

    void appendRoom(String str) {
        controllerServer.writeInChatEventsListView(str);
    }

    void appendEvent(String str) {
        controllerServer.writeInEventsListView(str);

    }

    public void actionPerformed(String portString) {
        // if running we have to stop
        if (server != null) {
            server.stop();
            server = null;
            controllerServer.setTextFromButtonSwitchContext("Start");
            controllerServer.setPortNumberTextFieldEditable(true);
            return;
        }
        // OK start the server
        int port;
        try {
            port = Integer.parseInt(portString);
        } catch (Exception er) {
            appendEvent("Invalid port number");
            return;
        }
        // ceate a new Server
        server = new Server(port, this);
        // and start it as a thread
        new ServerRunning().start();
        controllerServer.setTextFromButtonSwitchContext("Stop");
        controllerServer.setPortNumberTextFieldEditable(false);
    }


    class ServerRunning extends Thread {
        public void run() {
            server.start();         // should execute until if fails
            // the server failed
            controllerServer.setTextFromButtonSwitchContext("Start");
            controllerServer.setPortNumberTextFieldEditable(true);
            appendEvent("Server crashed\n");
            server = null;
        }
    }

    public Server getServer() {
        return server;
    }

}
