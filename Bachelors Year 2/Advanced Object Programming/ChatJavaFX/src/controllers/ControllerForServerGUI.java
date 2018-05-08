package controllers;

import chat.ServerGUI;
import javafx.application.Platform;
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

    @FXML
    public void switchContext() {

        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String port = portNumberTextField.getText().trim();
                serverGUI.actionPerformed(port);
            }
        });
    }

    public void writeInEventsListView(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                eventsListView.getItems().add(text);
            }
        });
    }

    public void writeInChatEventsListView(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                chatEventsListView.getItems().add(text);
            }
        });
    }

    public void setPortNumberTextFieldEditable(boolean val) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                if (val)
                    portNumberTextField.setEditable(true);
                else
                    portNumberTextField.setEditable(false);
            }
        });
    }

    public void setTextFromButtonSwitchContext(String val) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                switchButton.setText(val);
            }
        });
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }
}