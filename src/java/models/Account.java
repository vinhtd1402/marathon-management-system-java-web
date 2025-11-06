package models;

import java.sql.Timestamp;
import java.util.Date;

public class Account {
     public int uID;
    public String fullName;
    public String gender;
    public String username;
    public String password;
    public int age;
    public String healthStatus;
    public String email;
    public String phone;
    public int roleID;
    public double totalDistance;
    public Date createdAt;
    public boolean isDeleted;

    
    
    public Account() {}

    public Account(int uID, String fullName, String gender, String username, String password, int age, String healthStatus, String email, String phone, int roleID, double totalDistance, Date createdAt, boolean isDeleted) {
        this.uID = uID;
        this.fullName = fullName;
        this.gender = gender;
        this.username = username;
        this.password = password;
        this.age = age;
        this.healthStatus = healthStatus;
        this.email = email;
        this.phone = phone;
        this.roleID = roleID;
        this.totalDistance = totalDistance;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
    }


    public int getuID() {
        return uID;
    }

    public void setuID(int uID) {
        this.uID = uID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getHealthStatus() {
        return healthStatus;
    }

    public void setHealthStatus(String healthStatus) {
        this.healthStatus = healthStatus;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public double getTotalDistance() {
        return totalDistance;
    }

    public void setTotalDistance(double totalDistance) {
        this.totalDistance = totalDistance;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

  



    
}
