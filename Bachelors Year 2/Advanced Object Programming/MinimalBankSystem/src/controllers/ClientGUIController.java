package controllers;

import gui.ClientGUI;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import java.net.URL;
import java.util.ResourceBundle;


public class ClientGUIController implements Initializable {

    @FXML
    private Label infoLabel;

    @FXML
    private Label nameLabel;

    @FXML
    private TextField amountTextField;

    private ClientGUI clientGUI;

    private double currentAmount = 0;

    public ClientGUIController() {
        this(null);
    }

    public ClientGUIController(ClientGUI clientGUI) {
        this.clientGUI = clientGUI;
    }

    @FXML
    public void logOut() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                clientGUI.exit();
            }
        });
    }

    @FXML
    public void inquiry() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                try {
                    setInfoLabel("Amount is " + clientGUI.makeInquiry());
                } catch (Exception e) {
                    setInfoLabel("An error occurred...\n");
                }
            }
        });
    }

    @FXML
    public void deposit() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                int amount = 0;
                try {
                    amount = Integer.parseInt(amountTextField.getText().trim());
                } catch (Exception e) {
                    setInfoLabel("The amount is not good...\n");
                    return;
                }
                try {
                    setInfoLabel("Now Amount is " + clientGUI.makeDeposit(amount));
                } catch (Exception e) {
                    setInfoLabel("An error occurred...\n");
                    return;
                }
            }
        });
    }

    @FXML
    public void widthdraw() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                int amount = 0;
                try {
                    amount = Integer.parseInt(amountTextField.getText().trim());
                } catch (Exception e) {
                    setInfoLabel("The amount is not good...\n");
                    return;
                }
                try {
                    setInfoLabel("Now Amount is " + clientGUI.makeWidthdraw(amount));
                } catch (Exception e) {
                    setInfoLabel("An error occurred...\n");
                    return;
                }
            }
        });
    }

    public void setInfoLabel(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                infoLabel.setText(text);
            }
        });
    }

    public void setNameLabel(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                nameLabel.setText(text);
            }
        });
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {

    }
}