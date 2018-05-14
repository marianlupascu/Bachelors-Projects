package controllers;

import chat.ClientGUI;
import chat.Message;
import chat.Options;
import javafx.application.Platform;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ListView;
import javafx.scene.control.TextArea;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.util.Pair;

import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.ResourceBundle;


public class ControllerForChatWindow implements Initializable {

    static private ArrayList listOfNameForImageLogo = new ArrayList(Arrays.asList("1.-Batman", "2.-Spidey", "3.-Wolverine", "5.-Ironman",
            "6.-Cat-woman", "7.-Flash", "8.-Thor", "9.-Superman"));
    private boolean broadcastToggle = false;
    private String selected;

    @FXML
    private ListView messagesListView;

    @FXML
    private ListView usersListView;

    @FXML
    private TextArea inputContentTextArea;

    @FXML
    private ImageView logoImage;

    private ClientGUI clientGUI;

    public ControllerForChatWindow() {
        this(null);
    }

    public ControllerForChatWindow(ClientGUI clientGUI) {
        this.clientGUI = clientGUI;
//      logoImage.setImage(new Image("../img/" + listOfNameForImageLogo.get(4) + ".jpg"));
    }

    @FXML
    public void seeWhoIsIn() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                clientGUI.getClient().sendMessage(new Message(Options.SEEALLUSERS, "", Integer.MAX_VALUE));
            }
        });
    }

    @FXML
    public void logOut() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                clientGUI.getClient().sendMessage(new Message(Options.LOGOUT, "", Integer.MAX_VALUE));
                clientGUI.connectionFailed();
            }
        });
    }

    @FXML
    public void sendMessage() {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                if (broadcastToggle)
                    clientGUI.getClient().sendMessage
                            (new Message(Options.BROADCASTMESSAGE, inputContentTextArea.getText(), Integer.MAX_VALUE));
                else if (usersListView.getItems().size() > 0)
                    clientGUI.getClient().sendMessage
                            (new Message(Options.SENDAMESSAGE, inputContentTextArea.getText(), Integer.parseInt(selected)));
            }
        });
    }

    @FXML
    public void handleToggleAction() {
        broadcastToggle = !broadcastToggle;
    }

    public void write(String text) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                messagesListView.getItems().add(text);
            }
        });
    }

    public void updateListofClients(ArrayList<Pair<String, Integer>> list) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                usersListView.getItems().clear();
                usersListView.getSelectionModel().clearSelection();
                for (Pair<String, Integer> i : list)
                    usersListView.getItems().add(i.getKey() + " (" + i.getValue() + ")");
            }
        });
    }

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        Platform.runLater(new Runnable() {
            @Override
            public void run() {
                usersListView.setOnMouseClicked(new ListViewHandler() {
                    @Override
                    public void handle(javafx.scene.input.MouseEvent event) {
                        selected = (String) usersListView.getSelectionModel().getSelectedItem();
                        selected = selected.substring(selected.lastIndexOf('(') + 1, selected.length() - 1);
                    }
                });
            }
        });
    }
}

class ListViewHandler implements EventHandler<MouseEvent> {
    @Override
    public void handle(MouseEvent event) {
        //this method will be overrided in next step
    }
}