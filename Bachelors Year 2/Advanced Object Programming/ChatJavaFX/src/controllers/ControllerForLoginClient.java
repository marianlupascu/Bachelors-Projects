package controllers;

import chat.ClientGUI;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextField;
import javafx.scene.control.PasswordField;
import javafx.scene.control.Label;

import java.net.URL;
import java.util.ResourceBundle;
import java.lang.String;
import java.lang.System;
import java.lang.Integer;

public class ControllerForLoginClient implements Initializable {

    @FXML
    private TextField usernameField;

    @FXML
    private PasswordField passwordField;

    @FXML
    private TextField localHostField;

    @FXML
    private TextField portNumberField;

    @FXML
    private Label warmingMessagesField;

    private String userName;
    private String password;
    private String host;
    private int port;
    private ClientGUI clientGUI;

    public ControllerForLoginClient(){
        this(null);
    }

    public ControllerForLoginClient(ClientGUI clientGUI){
        this.clientGUI = clientGUI;
        userName = "";
        password = "";
        host = "";
        port = 0;
    }

    public void getInformations() {

        userName = new String(usernameField.getText().trim());
        password = new String(passwordField.getText().trim());
        host = new String(localHostField.getText().trim());
        try {
            port = Integer.parseInt(portNumberField.getText().trim());
            warmingMessagesField.setText("");
        } catch (Exception er) {
            warmingMessagesField.setText("Invalid port number");
            return;
        }

        if(port <= 0) {
            warmingMessagesField.setText("Invalid port number");
            return;
        }
        else
            warmingMessagesField.setText("");
        clientGUI.notifyGUI(userName, password, host, port);
    }

    public final String getUserName () {
        return userName;
    }
    public final String getPassword () {
        return password;
    }
    public final String getHostName () {
        return host;
    }
    public final int getPort () {
        return port;
    }
    public final void setInfoLabel(String text) {
        warmingMessagesField.setText(text);
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }
}
