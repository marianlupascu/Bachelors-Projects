package rmi;

import gui.ClientGUI;

import java.rmi.Naming;

public class RmiClient implements ClientInterface {

    private ClientGUI clientGUI;
    private RmiServerIntf serverIntf;
    private String name;
    private int id;

    public RmiClient() throws Exception {
        this(null);
    }

    public RmiClient(ClientGUI clientGUI) throws Exception {
        this.clientGUI = clientGUI;
        serverIntf = (RmiServerIntf) Naming.lookup("//localhost/RmiServer");
    }

    public boolean init(int id, int password) throws Exception {
        name = serverIntf.isClient(id, password);
        if (name == null) {
            return false;
        } else {
            this.id = id;
            return true;
        }
    }

    public String getName() {
        return name;
    }

    @Override
    public double inquiry() throws Exception {
        return serverIntf.inquiry(id);
    }

    @Override
    public double deposit(int amount) throws Exception {
        return serverIntf.deposit(id, amount);
    }

    @Override
    public double widthdraw(int amount) throws Exception {
        return serverIntf.widthdraw(id, amount);
    }

    public void start() {
    }
}