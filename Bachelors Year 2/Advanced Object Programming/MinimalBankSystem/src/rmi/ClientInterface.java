package rmi;

public interface ClientInterface {
    public double inquiry() throws Exception;

    public double deposit(int amount) throws Exception;

    public double widthdraw(int amount) throws Exception;
}
