package chat;

import javafx.util.Pair;

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class Server {

    private static final int defaultPortNumber = 500;
    private static int currentID;
    private ArrayList<ClientsThreads> listOfClients;
    private ServerGUI sg;
    private SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");
    private int portNumber;
    private boolean keepGoing = false;

    public Server() {

        this(defaultPortNumber, null);
    }

    public Server(int port) {

        this(port, null);
    }

    public Server(int port, ServerGUI sg) {

        this.sg = sg;
        this.portNumber = port;
        listOfClients = new ArrayList<ClientsThreads>();
    }

    public static void main(String[] args) {

        int portNumber = defaultPortNumber;
        switch (args.length) {
            case 1:
                try {
                    portNumber = Integer.parseInt(args[0]);
                } catch (Exception e) {
                    System.out.println("Invalid port number.");
                    System.out.println("Try in this way: > java Server [portNumber]");
                    return;
                }
            case 0:
                break;
            default:
                System.out.println("Try in this way: > java Server [portNumber]");
                return;

        }
        Server server = new Server(portNumber);
        server.start();
    }

    public void start() {

        keepGoing = true;
        try {
            ServerSocket serverSocket = new ServerSocket(portNumber);
            while (keepGoing) {
                displayOnGUI("Server waiting for Clients on port " + portNumber + ".");

                Socket socket = serverSocket.accept();
                if (!keepGoing)
                    break;
                ClientsThreads newClient = new ClientsThreads(socket);
                listOfClients.add(newClient);

                newClient.start();
            }
            try {
                serverSocket.close();
                for (int i = 0; i < listOfClients.size(); ++i) {
                    ClientsThreads currentClient = listOfClients.get(i);
                    try {
                        currentClient.inputStream.close();
                        currentClient.outputStream.close();
                        currentClient.socket.close();
                        displayOnGUI(currentClient.username + " is closed " + "\n");
                    } catch (IOException e) {
                        displayOnGUI("Exception closing clients: " + e + "\n");
                    }
                }
            } catch (Exception e) {
                displayOnGUI("Exception closing the server and clients: " + e + "\n");
            }
        } catch (IOException e) {
            String msg = dateFormat.format(new Date()) + " Exception on new ServerSocket: " + e + "\n";
            displayOnGUI(msg);
        }
    }

    protected void stop() {
        keepGoing = false;
        try {
            Socket socket = new Socket("localhost", portNumber);
        } catch (Exception e) {
            displayOnGUI("Exception closing the server: " + e + "\n");
        }
    }

    private void displayOnGUI(String msg) {
        String message = dateFormat.format(new Date()) + " " + msg;
        if (sg == null)
            System.out.println(message);
        else
            sg.appendEvent(message + "\n");
    }

    private synchronized void broadcast(String messageInput) {
        String time = dateFormat.format(new Date());
        String message = time + " " + messageInput + "\n";
        if (sg == null)
            System.out.print(message);
        else
            sg.appendRoom(message);

        // we loop in reverse order in case we would have to remove a Client
        // because it has disconnected
        for (int i = listOfClients.size() - 1; i >= 0; --i) {
            ClientsThreads currentClient = listOfClients.get(i);
            if (!currentClient.isOnline()) {
                listOfClients.remove(i);
                displayOnGUI("Disconnected Client " + currentClient.username + " removed from list.");
            } else
                currentClient.writeMsg(message);
        }
    }

    private synchronized void send(String messageInput, int id) {
        String time = dateFormat.format(new Date());
        String message = time + " " + messageInput + "\n";
        if (sg == null)
            System.out.print(message);
        else
            sg.appendRoom(message);

        // we loop in reverse order in case we would have to remove a Client
        // because it has disconnected
        for (int i = listOfClients.size() - 1; i >= 0; --i) {
            ClientsThreads currentClient = listOfClients.get(i);
            if (currentClient.getUserId() == id) {
                if (!currentClient.isOnline()) {
                    listOfClients.remove(i);
                    displayOnGUI("Disconnected Client " + currentClient.username + " removed from list.");
                } else {
                    currentClient.writeMsg(message);
                    break;
                }
            }
        }
    }

    private synchronized void updateListOfClients() {
        for (int i = listOfClients.size() - 1; i >= 0; --i) {
            ClientsThreads currentClient = listOfClients.get(i);
            if (!currentClient.isOnline()) {
                listOfClients.remove(i);
            }
        }
    }

    synchronized void remove(int id) {
        for (int i = 0; i < listOfClients.size(); ++i) {
            ClientsThreads currentClient = listOfClients.get(i);
            if (currentClient.id == id) {
                listOfClients.remove(i);
                return;
            }
        }
    }

    synchronized int getAviableID() {
        currentID++;
        return currentID;
    }

    synchronized ArrayList<Pair<String, Integer>> getListOfClients() {
        ArrayList<Pair<String, Integer>> l = new ArrayList<Pair<String, Integer>>();
        for (int i = 0; i < listOfClients.size(); ++i) {
            ClientsThreads currentClient = listOfClients.get(i);
            l.add(new Pair<String, Integer>(currentClient.getUsername(), currentClient.getUserId()));
        }
        return l;
    }

    class ClientsThreads extends Thread {

        Socket socket;
        ObjectInputStream inputStream;
        ObjectOutputStream outputStream;
        int id;
        String username;
        Message messageContent;
        String date;

        ClientsThreads(Socket socket) {
            id = getAviableID();
            this.socket = socket;
            try {
                outputStream = new ObjectOutputStream(socket.getOutputStream());
                inputStream = new ObjectInputStream(socket.getInputStream());
                username = (String) inputStream.readObject();
                displayOnGUI(username + " just connected.");
                broadcast(username + " just connected.");
            } catch (IOException e) {
                displayOnGUI("Exception creating new Input/output Streams: " + e);
                return;
            } catch (ClassNotFoundException e) {

            }
            date = new Date().toString() + "\n";
        }

        public void run() {

            boolean keepGoingThread = true;
            while (keepGoingThread) {
                try {
                    messageContent = (Message) inputStream.readObject();
                } catch (IOException e) {
                    displayOnGUI(username + " Exception reading Streams: " + e);
                    break;
                } catch (ClassNotFoundException e) {
                    break;
                }

                switch (messageContent.getOption()) {

                    case SENDAMESSAGE:
                        send(username + ": " + messageContent.getMessage(), messageContent.getUserId());
                        send(username + ": " + messageContent.getMessage(), id);
                        break;
                    case BROADCASTMESSAGE:
                        broadcast(username + ": " + messageContent.getMessage());
                        break;
                    case LOGOUT:
                        displayOnGUI(username + " disconnected with a LOGOUT message.");
                        broadcast(username + " just got out");
                        keepGoingThread = false;
                        break;
                    case SEEALLUSERS:
                        writeMsg("List of the users connected at " + dateFormat.format(new Date()) + "\n");
                        for (int i = 0; i < listOfClients.size(); ++i) {
                            ClientsThreads currentClient = listOfClients.get(i);
                            writeMsg((i + 1) + ") " + currentClient.username + " since " + currentClient.date);
                        }
                        break;
                }
            }
            remove(id);
            close();
        }

        private void close() {
            try {
                if (outputStream != null) outputStream.close();
            } catch (Exception e) {
            }
            try {
                if (inputStream != null) inputStream.close();
            } catch (Exception e) {
            }
            try {
                if (socket != null) socket.close();
            } catch (Exception e) {
            }
        }

        private boolean isOnline() {
            if (!socket.isConnected()) {
                close();
                return false;
            }
            return true;
        }

        private void writeMsg(String msg) {
            try {
                updateListOfClients();
                outputStream.writeObject(new Pair<String, ArrayList<Pair<String, Integer>>>(msg, getListOfClients()));
            } catch (IOException e) {
                displayOnGUI("Error sending message to " + username);
                displayOnGUI(e.toString());
            }
        }

        String getUsername() {
            return username;
        }

        int getUserId() {
            return id;
        }
    }
}