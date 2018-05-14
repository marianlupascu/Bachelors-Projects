package rmi;

public abstract class RmiClientDecorator implements ClientInterface {

    protected final ClientInterface decoratedRmiClient;

    public RmiClientDecorator(ClientInterface c) {
        this.decoratedRmiClient = c;
    }

    @Override
    public double inquiry() throws Exception {
        return decoratedRmiClient.inquiry();
    }

    @Override
    public double deposit(int amount) throws Exception {
        return decoratedRmiClient.deposit(amount);
    }

    @Override
    public double widthdraw(int amount) throws Exception {
        return decoratedRmiClient.widthdraw(amount);
    }
}
