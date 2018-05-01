package chat;

import java.io.Serializable;

public class Message implements Serializable {

    private static final long serialVersionUID = 1L;

    private Options option;
    private String message;

    public Message() {
        this.option = Options.SENDAMESSAGE;
        this.message = "";
    }

    public Message(Options option, String message) {
        this.option = option;
        this.message = message;
    }

    Options getOption() {
        return option;
    }

    String getMessage() {
        return message;
    }
}