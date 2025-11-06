/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import models.Account;

/**
 *
 * @author Administrator
 */
public class AccountDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    // Đăng nhập
    public Account checkLogin(String username, String password) {
        Account account = null;
        try {
            String sql = "SELECT * FROM Account WHERE Username = ? AND Password = ? AND IsDeleted = 0";
            stm = connection.prepareCall(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            rs = stm.executeQuery();
            if (rs.next()) {
                account = new Account(
                        rs.getInt("uID"),
                        rs.getString("FullName"),
                        rs.getString("Gender"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getInt("Age"),
                        rs.getString("HealthStatus"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getInt("RoleID"),
                        rs.getDouble("TotalDistance"),
                        rs.getDate("CreatedAt"),
                        rs.getBoolean("IsDeleted")
                );
            }
        } catch (Exception e) {
            System.out.println("checkLogin: " + e.getMessage());
        }
        return account;
    }

    // Tạo tài khoản
    public Account CreateAccount(Account account) {
        Account found = GetAccountByUsername(account.username);
        if (found != null) {
            return null; // username đã tồn tại
        }
        try {
            String strSQL = "INSERT INTO Account (FullName, Gender, Username, Password, Age, HealthStatus, Email, Phone, RoleID, TotalDistance, CreatedAt, IsDeleted) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 0, GETDATE(), 0)";
            stm = connection.prepareCall(strSQL);
            stm.setString(1, account.fullName);
            stm.setString(2, account.gender);
            stm.setString(3, account.username);
            stm.setString(4, account.password);
            stm.setInt(5, account.age);
            stm.setString(6, account.healthStatus);
            stm.setString(7, account.email);
            stm.setString(8, account.phone);
            stm.setInt(9, account.roleID);
            stm.execute();
        } catch (Exception ex) {
            System.out.println("CreateAccount: " + ex.getMessage());
        }
        return account;
    }

    // Lấy account theo username
    public Account GetAccountByUsername(String username) {
        Account account = null;
        try {
            String sql = "SELECT * FROM Account WHERE Username = ?";
            stm = connection.prepareCall(sql);
            stm.setString(1, username);
            rs = stm.executeQuery();
            if (rs.next()) {
                account = new Account(
                        rs.getInt("uID"),
                        rs.getString("FullName"),
                        rs.getString("Gender"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getInt("Age"),
                        rs.getString("HealthStatus"),
                        rs.getString("Email"),
                        rs.getString("Phone"),
                        rs.getInt("RoleID"),
                        rs.getDouble("TotalDistance"),
                        rs.getDate("CreatedAt"),
                        rs.getBoolean("IsDeleted")
                );
            }
        } catch (Exception ex) {
            System.out.println("GetAccountByUsername: " + ex.getMessage());
        }
        return account;
    }

    public List<Account> getAccounts() {
        List<Account> accounts = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Account WHERE IsDeleted = 0";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Account a = new Account();
                a.setuID(rs.getInt("uID"));
                a.setFullName(rs.getString("fullName"));
                a.setGender(rs.getString("gender"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setAge(rs.getInt("age"));
                a.setHealthStatus(rs.getString("healthStatus"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setRoleID(rs.getInt("roleID"));
                a.setTotalDistance(rs.getDouble("totalDistance"));
                a.setCreatedAt(rs.getDate("createdAt"));
                a.setIsDeleted(rs.getBoolean("IsDeleted"));
                accounts.add(a);
            }
        } catch (Exception e) {
            System.out.println("getAccounts: " + e.getMessage());
        }
        return accounts;
    }

    public Account getAccountById(int id) {
        Account a = null;
        try {
            String sql = "SELECT * FROM Account WHERE uID = ? AND IsDeleted = 0";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();
            if (rs.next()) {
                a = new Account();
                a.setuID(rs.getInt("uID"));
                a.setFullName(rs.getString("fullName"));
                a.setGender(rs.getString("gender"));
                a.setUsername(rs.getString("username"));
                a.setPassword(rs.getString("password"));
                a.setAge(rs.getInt("age"));
                a.setHealthStatus(rs.getString("healthStatus"));
                a.setEmail(rs.getString("email"));
                a.setPhone(rs.getString("phone"));
                a.setRoleID(rs.getInt("roleID"));
                a.setTotalDistance(rs.getDouble("totalDistance"));
                a.setCreatedAt(rs.getDate("createdAt"));
                a.setIsDeleted(rs.getBoolean("IsDeleted"));
            }
        } catch (Exception e) {
            System.out.println("getAccountById: " + e.getMessage());
        }
        return a;
    }

    public Account updateAccount(Account a) {
        Account found = getAccountById(a.uID);
        if (found == null) {
            return null;
        }
        try {
            String sql = "UPDATE Account SET fullName=?, gender=?, username=?, password=?, age=?, healthStatus=?, email=?, phone=?, roleID=?, totalDistance=? WHERE uID=?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, a.getFullName());
            stm.setString(2, a.getGender());
            stm.setString(3, a.getUsername());
            stm.setString(4, a.getPassword());
            stm.setInt(5, a.getAge());
            stm.setString(6, a.getHealthStatus());
            stm.setString(7, a.getEmail());
            stm.setString(8, a.getPhone());
            stm.setInt(9, a.getRoleID());
            stm.setDouble(10, a.getTotalDistance());
            stm.setInt(11, a.getuID());
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateAccount: " + e.getMessage());

        }
        return a;
    }

    public void softDeleteAccount(int id) {
        try {
            String sql = "UPDATE Account SET IsDeleted = 1 WHERE uID = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (Exception e) {
            System.out.println("softDeleteAccount: " + e.getMessage());
        }
    }

public List<Account> searchAccount(String keyword) {
    List<Account> list = new ArrayList<>();
    try {
        String sql = "SELECT * FROM Account WHERE IsDeleted = 0 AND "
                   + "(FullName LIKE ? OR Username LIKE ? OR Email LIKE ? OR Phone LIKE ?)";
        stm = connection.prepareStatement(sql);

        String kw = "%" + keyword + "%";
        stm.setString(1, kw);
        stm.setString(2, kw);
        stm.setString(3, kw);
        stm.setString(4, kw);

        rs = stm.executeQuery();

        while (rs.next()) {
            Account a = new Account();
            a.setuID(rs.getInt("uID"));
            a.setFullName(rs.getString("FullName"));
            a.setGender(rs.getString("Gender"));
            a.setUsername(rs.getString("Username"));
            a.setPassword(rs.getString("Password"));
            a.setAge(rs.getInt("Age"));
            a.setHealthStatus(rs.getString("HealthStatus"));
            a.setEmail(rs.getString("Email"));
            a.setPhone(rs.getString("Phone"));
            a.setRoleID(rs.getInt("RoleID"));
            a.setTotalDistance(rs.getDouble("TotalDistance"));
            a.setCreatedAt(rs.getTimestamp("CreatedAt"));
            a.setIsDeleted(rs.getBoolean("IsDeleted"));

            list.add(a);
        }
    } catch (Exception ex) {
        System.out.println("searchAccount: " + ex.getMessage());
    }
    return list;
}


}
