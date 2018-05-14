package patterns;

import chat.ClientGUI;

public class ClientFacade implements Facade {

    private ClientGUI clientGUI;

    public ClientFacade() {
        clientGUI = new ClientGUI();
    }

    public static void main(String[] args) {
        ClientFacade clientFacade = new ClientFacade();
        clientFacade.start();
    }

    @java.lang.Override
    public void start() {
        clientGUI.prepare();
    }
}
