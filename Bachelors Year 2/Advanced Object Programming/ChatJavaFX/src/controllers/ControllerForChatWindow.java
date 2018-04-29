package controllers;

import chat.ClientGUI;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextArea;
import javafx.scene.control.PasswordField;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;


import java.net.URL;
import java.util.ResourceBundle;
import java.lang.String;
import java.lang.System;
import java.lang.Integer;
import chat.Message;
import chat.Options;

public class ControllerForChatWindow implements Initializable {

    @FXML
    private ListView messagesListView;

    @FXML
    private TextArea inputContentTextArea;

    private ClientGUI clientGUI;

    public ControllerForChatWindow(){
        this(null);
    }

    public ControllerForChatWindow(ClientGUI clientGUI){
        this.clientGUI = clientGUI;
    }

    public void seeWhoIsIn() {
        clientGUI.getClient().sendMessage(new Message(Options.SEEALLUSERS, ""));
    }

    public void logOut () {
        clientGUI.getClient().sendMessage(new Message(Options.LOGOUT, ""));
        clientGUI.connectionFailed();
    }

    public void sendMessage() {
        clientGUI.getClient().sendMessage(new Message(Options.SENDAMESSAGE, inputContentTextArea.getText()));
    }

    public void write(String text) {
        messagesListView.getItems().add(text);
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }
}
