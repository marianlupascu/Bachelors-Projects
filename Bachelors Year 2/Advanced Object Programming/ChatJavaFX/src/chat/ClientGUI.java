package chat;

import controllers.ControllerForChatWindow;
import controllers.ControllerForLoginClient;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;

public class ClientGUI extends Application {

    private boolean connected;
    private Client client;
    private int defaultPort;
    private String defaultHost;
    private ControllerForLoginClient controller;
    private ControllerForChatWindow controllerChat;
    private Stage primaryStage;

    public static void main(String[] args) {
        try {
            launch(args);
        } catch (Exception e) {
        }
    }

    void setStage(String resource) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource(resource));

        controller = new ControllerForLoginClient(this);
        // Set it in the FXMLLoader
        loader.setController(controller);

        Parent root = (Parent) loader.load();
        Image applicationIcon = new Image(getClass().getResourceAsStream("../resources/img/favicon.png"));
        primaryStage.getIcons().add(applicationIcon);
        primaryStage.setTitle("SpaceChat - Login");
        primaryStage.setScene(new Scene(root));
        primaryStage.show();
    }

    @Override
    public void start(Stage primaryStage) throws Exception {

        this.primaryStage = primaryStage;
        setStage("../resources/xml/LoginClient_css.fxml");
        try {

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void notifyGUI(String username, String password, String hostName, int portNumber) {
//        System.out.println(username);
//        System.out.println(password);
//        System.out.println(hostName);
//        System.out.println(portNumber);
        if (parseInformation(username, password, hostName, portNumber)) {
            controller.setInfoLabel("Sign in...");

            client = new Client(hostName, portNumber, username, this);
            if (!client.start()) {
                return;
            }

            try {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("../resources/xml/ChatWindow_css.fxml"));

                controllerChat = new ControllerForChatWindow(this);

                // Set it in the FXMLLoader
                loader.setController(controllerChat);

                Parent root = (Parent) loader.load();
                Image applicationIcon = new Image(getClass().getResourceAsStream("../resources/img/favicon.png"));
                primaryStage.getIcons().add(applicationIcon);
                primaryStage.setTitle("SpaceChat - " + username);
                primaryStage.setScene(new Scene(root));
                primaryStage.show();
            } catch (Exception e) {
                e.printStackTrace();
            }

            controller = null;
            defaultPort = portNumber;
            defaultHost = hostName;

            connected = true;
        } else {
            controller.setInfoLabel("Something went wrong. Please try again! (fields can not be empty)");
            return;
        }
    }

    protected boolean parseInformation(String username, String password, String hostName, int portNumber) {
        if (username.length() == 0)
            return false;
        if (false) { // false-mince search in a data base information between username and password os something like this
            return false;
        }
        if (hostName.length() == 0)
            return false;
        return true;
    }

    void append(String str) {
        controllerChat.write(str);
    }

    public void connectionFailed() {
        try {
            setStage("../resources/xml/LoginClient_css.fxml");
        } catch (Exception e) {
            e.printStackTrace();
        }
        connected = false;
    }

    public Client getClient() {
        return client;
    }

    public ControllerForLoginClient getControllerForLoginClient() {
        return controller;
    }

    public ControllerForChatWindow getControllerForChat() {
        return controllerChat;
    }
}