package gui;

import controllers.ClientGUIController;
import controllers.LoginController;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.stage.Stage;
import rmi.RmiClient;

public class ClientGUI extends Application {

    private RmiClient rmiClient;
    private LoginController loginController;
    private ClientGUIController clientGUIController;
    private Stage primaryStage;

    public static void main(String[] args) {
        launch(args);
    }

    void setStage(String resource) throws Exception {
        FXMLLoader loader = new FXMLLoader(getClass().getResource(resource));

        loginController = new LoginController(this);
        // Set it in the FXMLLoader
        loader.setController(loginController);

        Parent root = (Parent) loader.load();
        Image applicationIcon = new Image(getClass().getResourceAsStream("../resources/img/bankLogo.png"));
        primaryStage.getIcons().add(applicationIcon);
        primaryStage.setTitle("WolfBank ATM - Login");
        primaryStage.setScene(new Scene(root));
        primaryStage.show();
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        try {
            this.primaryStage = primaryStage;
            setStage("../resources/xml/LoginInterface_css.fxml");
            start();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void notifyGUI(String id, String password) {
//        System.out.println(id);
//        System.out.println(password);

        if (parseInformation(id, password)) {
//            loginController.setInfoLabel("Sign in...");

            try {
                FXMLLoader loader = new FXMLLoader(getClass().getResource("../resources/xml/ClientGUI_css.fxml"));

                clientGUIController = new ClientGUIController(this);

                // Set it in the FXMLLoader
                loader.setController(clientGUIController);

                Parent root = (Parent) loader.load();
                Image applicationIcon = new Image(getClass().getResourceAsStream("../resources/img/bankLogo.png"));
                primaryStage.getIcons().add(applicationIcon);
                primaryStage.setTitle("Welcome to WolfBank");
                primaryStage.setScene(new Scene(root));
                primaryStage.show();
            } catch (Exception e) {
                e.printStackTrace();
            }

            loginController = null;

            updateName();
        } else {
            return;
        }
    }

    public void updateName() {
        String name = rmiClient.getName();
        clientGUIController.setNameLabel("Mr. " + name + ", ");
    }

    protected boolean parseInformation(String id, String password) {
        int idClient = -1;
        int passwordClient = -1;

        if (id.equals("")) {
            loginController.setInfoLabel("The id field can not be empty... \n");
            return false;
        }
        if (password.equals("")) {
            loginController.setInfoLabel("The password field can not be empty... \n");
            return false;
        }

        try {
            idClient = Integer.parseInt(id);
            passwordClient = Integer.parseInt(password);
        } catch (Exception e) {
            loginController.setInfoLabel("Something went wrong with your id or password, try again! " + e.getMessage());
            return false;
        }
        try {
            if (rmiClient.init(idClient, passwordClient)) {
                return true;
            } else {
                loginController.setInfoLabel("You may have mistaken your password, try again! \n");
                return false;
            }
        } catch (Exception e) {
            loginController.setInfoLabel("Something went wrong, try again! " + e.getMessage());
            return false;
        }
    }

    public void exit() {
        try {
            setStage("../resources/xml/LoginInterface_css.fxml");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public LoginController getLoginController() {
        return loginController;
    }

    public ClientGUIController getClientGUIController() {
        return clientGUIController;
    }

    public double makeInquiry() throws Exception {
        return rmiClient.inquiry();
    }

    public double makeDeposit(int amount) throws Exception {
        return rmiClient.deposit(amount);
    }

    public double makeWidthdraw(int amount) throws Exception {
        return rmiClient.widthdraw(amount);
    }

    public void start() {
        // ceate a new Server
        try {
            rmiClient = new RmiClient(this);
            // and start it as a thread
            new ClientRunning().start();
        } catch (Exception e) {
        }
    }

    class ClientRunning extends Thread {
        public void run() {
            try {
                rmiClient.start();         // should execute until if fails
            } catch (Exception e) {
                rmiClient = null;
            }
        }
    }
}