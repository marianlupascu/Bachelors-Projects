package controllers;

import chat.ClientGUI;
import chat.Message;
import chat.Options;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.ListView;
import javafx.scene.control.TextArea;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;

import java.net.URL;
import java.util.ResourceBundle;
import java.util.ArrayList;
import java.util.Arrays;

public class ControllerForChatWindow implements Initializable {

    static private ArrayList listOfNameForImageLogo = new ArrayList(Arrays.asList("1.-Batman", "2.-Spidey", "3.-Wolverine", "5.-Ironman",
            "6.-Cat-woman", "7.-Flash", "8.-Thor", "9.-Superman"));

    @FXML
    private ListView messagesListView;

    @FXML
    private TextArea inputContentTextArea;

    @FXML
    private ImageView logoImage;

    private ClientGUI clientGUI;

    public ControllerForChatWindow(){
        this(null);
    }

    public ControllerForChatWindow(ClientGUI clientGUI){
        this.clientGUI = clientGUI;
//        logoImage.setImage(new Image("../img/" + listOfNameForImageLogo.get(4) + ".jpg"));
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