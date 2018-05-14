package rmi;

public class LegalPersonClient extends RmiClientDecorator {
    public LegalPersonClient(ClientInterface c) {
        super(c);
    }

    public double inquiry() throws Exception {
        super.widthdraw(1);
        return super.inquiry();
    }

    public double deposit(int amount) throws Exception {
        super.widthdraw(1);
        return super.deposit(amount);
    }

    public double widthdraw(int amount) throws Exception {
        return super.widthdraw(amount + 1);
    }
}
