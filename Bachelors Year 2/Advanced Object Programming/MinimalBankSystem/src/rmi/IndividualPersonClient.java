package rmi;

public class IndividualPersonClient extends RmiClientDecorator {
    public IndividualPersonClient(ClientInterface c) {
        super(c);
    }

    public double inquiry() throws Exception {
        return super.inquiry();
    }

    public double deposit(int amount) throws Exception {
        return super.deposit(amount);
    }

    public double widthdraw(int amount) throws Exception {
        return super.widthdraw(amount);
    }
}
