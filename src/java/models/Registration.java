package models;

import java.sql.Timestamp;

public class Registration {
    private int regID;
    private int eventID;
    private int runnerID;
    private Timestamp registerDate;
    private String paymentStatus;

    // Thêm quan hệ liên kết để hiển thị (JOIN)
    private Account runner;
    private MarathonEvent event;

    public Registration() {}

    public Registration(int regID, int eventID, int runnerID, Timestamp registerDate, String paymentStatus) {
        this.regID = regID;
        this.eventID = eventID;
        this.runnerID = runnerID;
        this.registerDate = registerDate;
        this.paymentStatus = paymentStatus;
    }

    public Registration(int regID, int eventID, int runnerID, Timestamp registerDate, String paymentStatus, Account runner, MarathonEvent event) {
        this.regID = regID;
        this.eventID = eventID;
        this.runnerID = runnerID;
        this.registerDate = registerDate;
        this.paymentStatus = paymentStatus;
        this.runner = runner;
        this.event = event;
    }
    
    
    

    public int getRegID() {
        return regID;
    }

    public void setRegID(int regID) {
        this.regID = regID;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public int getRunnerID() {
        return runnerID;
    }

    public void setRunnerID(int runnerID) {
        this.runnerID = runnerID;
    }

    public Timestamp getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(Timestamp registerDate) {
        this.registerDate = registerDate;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Account getRunner() {
        return runner;
    }

    public void setRunner(Account runner) {
        this.runner = runner;
    }

    public MarathonEvent getEvent() {
        return event;
    }

    public void setEvent(MarathonEvent event) {
        this.event = event;
    }
}
