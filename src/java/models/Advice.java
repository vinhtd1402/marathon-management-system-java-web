package models;

import java.sql.Timestamp;

public class Advice {
    private int adviceID;
    private int runnerID;
    private String title;
    private String message;
    private Timestamp createdAt;

    // Thêm Account nếu bạn muốn hiển thị thông tin người gửi
    private Account account;

    public int getAdviceID() {
        return adviceID;
    }

    public void setAdviceID(int adviceID) {
        this.adviceID = adviceID;
    }

    public int getRunnerID() {
        return runnerID;
    }

    public void setRunnerID(int runnerID) {
        this.runnerID = runnerID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }
}
