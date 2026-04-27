/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Registration;
import models.Account;
import models.MarathonEvent;

/**
 *
 * @author Administrator
 */
public class RegistrationDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    // 🔹 Thêm mới đăng ký (Runner nhấn “Đăng ký ngay”)
    public boolean addRegistration(int eventID, int runnerID) {
        try {
            String sql = "INSERT INTO Registration (EventID, RunnerID) VALUES (?, ?)";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, eventID);
            stm.setInt(2, runnerID);
            stm.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("addRegistration: " + e.getMessage());
        }
        return false;
    }

    // 🔹 Lấy danh sách tất cả các đăng ký (staff xem)
    public List<Registration> getAllRegistrations() {
        List<Registration> list = new ArrayList<>();
        try {
            String sql = "SELECT r.RegID, r.EventID, r.RunnerID, r.RegisterDate, r.PaymentStatus, "
                    + "a.FullName, a.Email, e.EventName, e.Fee "
                    + "FROM Registration r "
                    + "JOIN Account a ON r.RunnerID = a.uID "
                    + "JOIN MarathonEvent e ON r.EventID = e.EventID "
                    + "ORDER BY r.RegisterDate DESC";
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                Registration r = new Registration();
                r.setRegID(rs.getInt("RegID"));
                r.setEventID(rs.getInt("EventID"));
                r.setRunnerID(rs.getInt("RunnerID"));
                r.setRegisterDate(rs.getTimestamp("RegisterDate"));
                r.setPaymentStatus(rs.getString("PaymentStatus"));

                // Gắn thông tin phụ
                Account acc = new Account();
                acc.setFullName(rs.getString("FullName"));
                acc.setEmail(rs.getString("Email"));
                r.setRunner(acc);

                MarathonEvent ev = new MarathonEvent();
                ev.setEventName(rs.getString("EventName"));
                ev.setFee(rs.getDouble("Fee"));
                r.setEvent(ev);

                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("getAllRegistrations: " + e.getMessage());
        }
        return list;
    }

    // 🔹 Lấy danh sách đăng ký theo RunnerID (để runner xem lại giải của mình)
    public List<Registration> getRegistrationsByRunner(int runnerID) {
        List<Registration> list = new ArrayList<>();
        try {
            String sql = "SELECT r.RegID, r.EventID, r.RunnerID, r.RegisterDate, r.PaymentStatus, "
                    + "e.EventName, e.Fee "
                    + "FROM Registration r "
                    + "JOIN MarathonEvent e ON r.EventID = e.EventID "
                    + "WHERE r.RunnerID = ? ORDER BY r.RegisterDate DESC";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, runnerID);
            rs = stm.executeQuery();
            while (rs.next()) {
                Registration r = new Registration();
                r.setRegID(rs.getInt("RegID"));
                r.setEventID(rs.getInt("EventID"));
                r.setRunnerID(rs.getInt("RunnerID"));
                r.setRegisterDate(rs.getTimestamp("RegisterDate"));
                r.setPaymentStatus(rs.getString("PaymentStatus"));

                MarathonEvent ev = new MarathonEvent();
                ev.setEventName(rs.getString("EventName"));
                ev.setFee(rs.getDouble("Fee"));
                r.setEvent(ev);

                list.add(r);
            }
        } catch (Exception e) {
            System.out.println("getRegistrationsByRunner: " + e.getMessage());
        }
        return list;
    }

    // 🔹 Cập nhật trạng thái thanh toán (staff đổi từ Pending -> Paid)
   public boolean updatePaymentStatusAndDistance(int regID, String status) {
    try {
        // Cập nhật trạng thái thanh toán
        String sql = "UPDATE Registration SET PaymentStatus = ? WHERE RegID = ?";
        stm = connection.prepareStatement(sql);
        stm.setString(1, status);
        stm.setInt(2, regID);
        stm.executeUpdate();

        // Nếu là Paid -> cộng quãng đường
        if ("Paid".equalsIgnoreCase(status)) {
            String updateDistance = 
                "UPDATE Account SET TotalDistance = TotalDistance + " +
                "(SELECT mt.Distance FROM Registration r " +
                " JOIN MarathonEvent e ON r.EventID = e.EventID " +
                " JOIN MarathonType mt ON e.TypeID = mt.TypeID " +
                " WHERE r.RegID = ?) " +
                "WHERE uID = (SELECT RunnerID FROM Registration WHERE RegID = ?)";
            stm = connection.prepareStatement(  updateDistance);
            stm.setInt(1, regID);
            stm.setInt(2, regID);
            stm.executeUpdate();
        }
        return true;
    } catch (Exception e) {
        System.out.println("updatePaymentStatusAndDistance: " + e.getMessage());
    }
    return false;
}


    // 🔹 Xóa đơn đăng ký
   // 🔹 Xóa vật lý Registration kèm Payment liên quan
public boolean deleteRegistrationWithPayment(int regID) {
    try {
        connection.setAutoCommit(false); // Bắt đầu transaction

        // 1️⃣ Xóa Payment liên quan
        String sqlPay = "DELETE FROM Payment WHERE RegID = ?";
        stm = connection.prepareStatement(sqlPay);
        stm.setInt(1, regID);
        stm.executeUpdate();

        // 2️⃣ Xóa Registration
        String sqlReg = "DELETE FROM Registration WHERE RegID = ?";
        stm = connection.prepareStatement(sqlReg);
        stm.setInt(1, regID);
        stm.executeUpdate();

        connection.commit(); // Commit transaction
        return true;
    } catch (Exception e) {
        try {
            connection.rollback(); // Rollback nếu lỗi
        } catch (Exception ex) {
            System.out.println("rollback error: " + ex.getMessage());
        }
        System.out.println("deleteRegistrationWithPayment: " + e.getMessage());
    } finally {
        try {
            connection.setAutoCommit(true); // Reset lại auto commit
        } catch (Exception e) {
            System.out.println("setAutoCommit error: " + e.getMessage());
        }
    }
    return false;
}

    // Kiểm tra Runner đã có Registration đang Pending hay chưa
public boolean hasPendingRegistration(int runnerID) {
    try {
        String sql = "SELECT COUNT(*) AS count FROM Registration WHERE RunnerID = ? AND PaymentStatus = 'Pending'";
        
        stm = connection.prepareStatement(sql);
        stm.setInt(1, runnerID);
        rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getInt("count") > 0; // true nếu có pending
        }
    } catch (Exception e) {
        System.out.println("hasPendingRegistration: " + e.getMessage());
    }
    return false;
}

}
