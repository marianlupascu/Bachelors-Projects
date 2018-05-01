package controllers;

import chat.ServerGUI;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;

import java.net.URL;
import java.util.ResourceBundle;

public class ControllerForServerGUI implements Initializable {

    @FXML
    private ListView eventsListView;

    @FXML
    private ListView chatEventsListView;

    @FXML
    private TextField portNumberTextField;

    @FXML
    private Button switchButton;

    private ServerGUI serverGUI;

    public ControllerForServerGUI() {
        this(null);
    }

    public ControllerForServerGUI(ServerGUI serverGUI) {
        this.serverGUI = serverGUI;
    }

    public void switchContext() {

        String port = portNumberTextField.getText().trim();
        serverGUI.actionPerformed(port);
    }

    public void writeInEventsListView(String text) {
        eventsListView.getItems().add(text);
    }

    public void writeInChatEventsListView(String text) {
        chatEventsListView.getItems().add(text);
    }

    public void setPortNumberTextFieldEditable(boolean val) {
        if (val)
            portNumberTextField.setEditable(true);
        else
            portNumberTextField.setEditable(false);
    }

    public void setTextFromButtonSwitchContext(String val) {
        switchButton.setText(val);
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }
}