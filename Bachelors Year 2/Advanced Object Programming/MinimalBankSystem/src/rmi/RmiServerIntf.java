package rmi;

import java.rmi.Remote;
import java.rmi.RemoteException;

public interface RmiServerIntf extends Remote {
    public double deposit(int accountId, int amount) throws RemoteException;

    public double widthdraw(int accountId, int amount) throws RemoteException;

    public double inquiry(int accountId) throws RemoteException;

    public String isClient(int accountId, int password) throws RemoteException;
}