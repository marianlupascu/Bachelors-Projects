package chat;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.Socket;

public class Client {

    private ObjectInputStream sInput;        // to read from the socket
    private ObjectOutputStream sOutput;        // to write on the socket
    private Socket socket;

    private ClientGUI cg;

    private String server, username;
    private int port;

    Client(String server, int port, String username, ClientGUI cg) {
        this.server = server;
        this.port = port;
        this.username = username;
        this.cg = cg;
    }

    public boolean start() {

        try {
            socket = new Socket(server, port);
        }
        // if it failed not much I can so
        catch (Exception ec) {
            cg.getControllerForLoginClient().setInfoLabel("Error connectiong to server (probably is on other port " +
                    "or is closed):" + '\n' + ec);
            return false;
        }

        String msg = "Connection accepted " + socket.getInetAddress() + ":" + socket.getPort();
        cg.getControllerForLoginClient().setInfoLabel(msg);

		/* Creating both Data Stream */
        try {
            sInput = new ObjectInputStream(socket.getInputStream());
            sOutput = new ObjectOutputStream(socket.getOutputStream());
        } catch (IOException eIO) {
            cg.getControllerForLoginClient().setInfoLabel("Exception creating new Input/output Streams: " + '\n' + eIO);
            return false;
        }

        // creates the Thread to listen from the server
        new ListenFromServer().start();
        // Send our username to the server this is the only message that we
        // will send as a String. All other messages will be ChatMessage objects
        try {
            sOutput.writeObject(username);
        } catch (IOException eIO) {
            cg.getControllerForLoginClient().setInfoLabel("Exception doing login : " + eIO);
            disconnect();
            return false;
        }
        // success we inform the caller that it worked
        return true;
    }

    private void display(String msg) {

        cg.append(msg + "\n");
    }

    public void sendMessage(Message msg) {
        try {
            sOutput.writeObject(msg);
        } catch (IOException e) {
            display("Exception writing to server: " + e);
        }
    }

    private void disconnect() {
        try {
            if (sInput != null) sInput.close();
        } catch (Exception e) {
        }
        try {
            if (sOutput != null) sOutput.close();
        } catch (Exception e) {
        }
        try {
            if (socket != null) socket.close();
        } catch (Exception e) {
        }

        cg.connectionFailed();

    }

    class ListenFromServer extends Thread {

        public void run() {
            while (true) {
                try {
                    String msg = (String) sInput.readObject();

                    if (cg.getControllerForLoginClient() == null)
                        display(msg);

                } catch (IOException e) {
                    if (cg.getControllerForLoginClient() != null)
                        cg.getControllerForLoginClient().setInfoLabel("Server has close the connection: " + e);
                    else
                        display("Server has close the connection: " + e);

                    cg.connectionFailed();
                    break;
                } catch (ClassNotFoundException e2) {
                }
            }
        }
    }
}