package rmi;

public interface ClientInterface {
    public double inquiry() throws Exception;

    public double deposit(int amount) throws Exception;

    public double widthdraw(int amount) throws Exception;

    public void start();

    public String getName();

    public boolean init(int id, int password) throws Exception;
}
