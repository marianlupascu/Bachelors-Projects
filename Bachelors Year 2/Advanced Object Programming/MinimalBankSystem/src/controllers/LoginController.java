package controllers;

import gui.ClientGUI;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;

import java.net.URL;
import java.util.ResourceBundle;

public class LoginController implements Initializable {

    @FXML
    private Label informationLabel;

    @FXML
    private TextField idTextField;

    @FXML
    private PasswordField passwordField;

    private String id;
    private String password;
    private ClientGUI clientGUI;

    public LoginController() {
        this(null);
    }

    public LoginController(ClientGUI clientGUI) {
        this.clientGUI = clientGUI;
        id = "";
        password = "";
    }

    @FXML
    public void press1() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "1";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press2() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "2";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press3() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "3";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press4() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "4";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press5() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "5";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press6() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "6";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press7() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "7";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press8() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "8";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press9() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "9";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void press0() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "0";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void pressHashTag() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + "#";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void pressPoint() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                String currentPassword = passwordField.getText();
                currentPassword = currentPassword + ".";
                setPasswordField(currentPassword);
            }
        });
    }

    @FXML
    public void pressClear() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                setPasswordField("");
            }
        });
    }

    @FXML
    public void pressOk() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                clientGUI.notifyGUI(idTextField.getText().trim(), passwordField.getText().trim());
            }
        });
    }

    @FXML
    public void pressDismiss() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                Platform.exit();
            }
        });
    }

    public final String getId() {
        return id;
    }

    public final String getPassword() {
        return password;
    }

    public final void setInfoLabel(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                informationLabel.setText(text);
            }
        });
    }

    public final void setIdTextField(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                idTextField.setText(text);
            }
        });
    }

    public final void setPasswordField(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                passwordField.setText(text);
            }
        });
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
    }
}