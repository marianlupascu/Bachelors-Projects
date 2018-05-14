package gui;

import controllers.ServerController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import rmi.RmiServer;

public class ServerGUI extends Application {

    private RmiServer rmiServer = null;

    private ServerController serverController;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {

        try {
            FXMLLoader loader = new FXMLLoader(getClass().getResource("../resources/xml/ServerInterface_css.fxml"));

            serverController = new ServerController(this);
            // Set it in the FXMLLoader
            loader.setController(serverController);

            Parent root = (Parent) loader.load();
            Image applicationIcon = new Image(getClass().getResourceAsStream("../resources/img/bankLogo.png"));
            primaryStage.getIcons().add(applicationIcon);
            primaryStage.setTitle("Bank - ATM - ServerInterface");
            primaryStage.setScene(new Scene(root));
            primaryStage.show();

        } catch (Exception e) {
            e.printStackTrace();
        }
        rmiServer = null;
    }

    public void appendEvent(String str) {

        serverController.writeInEventsListView(str);
    }

    public void actionPerformed(String portString) {

        int port;
        try {
            port = Integer.parseInt(portString);
        } catch (Exception er) {
            appendEvent("Invalid port number");
            return;
        }
        // ceate a new Server
        try {
            rmiServer = new RmiServer(port, this);
            // and start it as a thread
            new ServerRunning().start();
        } catch (Exception e) {
        }

        serverController.setVisibilityFromButtonSwitchContext(false);
        serverController.setPortNumberTextFieldEditable(false);
    }

    public RmiServer getServer() {
        return rmiServer;
    }

    class ServerRunning extends Thread {
        public void run() {
            try {
                rmiServer.start();         // should execute until if fails
            } catch (Exception e) {
                // the server failed
                serverController.setVisibilityFromButtonSwitchContext(true);
                serverController.setPortNumberTextFieldEditable(true);
                appendEvent("Server crashed\n");
                rmiServer = null;
            }
        }
    }

}
