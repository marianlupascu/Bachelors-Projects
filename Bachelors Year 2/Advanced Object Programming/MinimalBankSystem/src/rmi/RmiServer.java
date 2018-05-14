package rmi;

import gui.ServerGUI;

import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Arrays;

public class RmiServer extends UnicastRemoteObject implements RmiServerIntf {

    static private ArrayList<Account> listOfClients = new ArrayList<Account>(Arrays.asList(
            new Account(1, "Red", 1234, 558.5),
            new Account(2, "Brown", 1234, 100000.5),
            new Account(3, "Green", 1234, 1000000000),
            new Account(4, "Black", 1234, -8.5),
            new Account(5, "Grey", 1234, 5)));
    private ServerGUI serverGUI;
    private int portNumer;

    public RmiServer() throws RemoteException {
        this(1099, null);
        System.out.println("Aici");
    }

    public RmiServer(int portNumer, ServerGUI serverGUI) throws RemoteException {
        this.portNumer = portNumer;
        this.serverGUI = serverGUI;
    }

    @java.lang.Override
    public String isClient(int accountId, int password) throws RemoteException {

        Account account = new Account(accountId, "", password, 0);
        for (int i = 0; i < listOfClients.size(); i++) {
            if (listOfClients.get(i).equals(account)) {
                return listOfClients.get(i).getName();
            }
        }
        return null;
    }

    @java.lang.Override
    public double deposit(int accountId, int amount) throws RemoteException {
        for (int i = 0; i < listOfClients.size(); i++) {
            if (listOfClients.get(i).getId() == accountId) {
                listOfClients.get(i).addMoney(amount);
                serverGUI.appendEvent("id: " + accountId + " deposit: " + amount);
                return listOfClients.get(i).getMoney();
            }
        }
        return 0;
    }

    @java.lang.Override
    public synchronized double inquiry(int accountId) throws RemoteException {
        for (int i = 0; i < listOfClients.size(); i++) {
            if (listOfClients.get(i).getId() == accountId) {
                serverGUI.appendEvent("id: " + accountId + " inquiry: " + listOfClients.get(i).getMoney());
                return listOfClients.get(i).getMoney();
            }
        }
        return 0;
    }

    @java.lang.Override
    public synchronized double widthdraw(int accountId, int amount) throws RemoteException {
        for (int i = 0; i < listOfClients.size(); i++) {
            if (listOfClients.get(i).getId() == accountId) {
                if (listOfClients.get(i).getMoney() < amount) {
                    serverGUI.appendEvent("id: " + accountId + " try widthdraw: " + amount);
                    return listOfClients.get(i).getMoney();
                } else {
                    listOfClients.get(i).minusMoney(amount);
                    serverGUI.appendEvent("id: " + accountId + " make widthdraw: " + amount);
                    return listOfClients.get(i).getMoney();
                }
            }
        }
        return 0;
    }

    public void start() throws Exception {

        serverGUI.appendEvent("RMI server started");

        try { //special exception handler for registry creation
            LocateRegistry.createRegistry(portNumer);
            serverGUI.appendEvent("java RMI registry created on port " + portNumer + ".");
        } catch (RemoteException e) {
            //do nothing, error means registry already exists
            serverGUI.appendEvent("java RMI registry already exists.");
        }

        //Instantiate RmiServer

        Naming.rebind("//localhost/RmiServer", this);
        serverGUI.appendEvent("PeerServer bound in registry");
    }
}