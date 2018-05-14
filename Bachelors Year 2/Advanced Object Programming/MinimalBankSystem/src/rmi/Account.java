package rmi;

public class Account {
    private int id;
    private String name;
    private int password;
    private double money;

    public Account(int id, String name, int password, double money) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.money = money;
    }

    public double getMoney() {
        return money;
    }

    public String getName() {
        return name;
    }

    public int getId() {
        return id;
    }

    public int getPassword() {
        return password;
    }

    public void addMoney(int money) {
        this.money = this.money + money;
    }

    public void minusMoney(int money) {
        this.money = this.money - money;
    }

    @Override
    public boolean equals(Object o) {
        // self check
        if (this == o)
            return true;
        // null check
        if (o == null)
            return false;
        // type check and cast
        if (getClass() != o.getClass())
            return false;
        Account account = (Account) o;
        // field comparison
        return id == account.getId() && password == account.getPassword();
    }
}