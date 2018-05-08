package chat;

import java.io.Serializable;

public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    private Options option;
    private String message;
    private int id;

    public Message() {
        this.option = Options.SENDAMESSAGE;
        this.message = "";
    }

    public Message(Options option, String message) {
        this.option = option;
        this.message = message;
    }

    public Message(Options option, String message, int id) {
        this.option = option;
        this.message = message;
        this.id = id;
    }

    Options getOption() {
        return option;
    }

    String getMessage() {
        return message;
    }

    int getUserId() {
        return id;
    }
}