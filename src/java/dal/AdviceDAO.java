package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Account;
import models.Advice;

public class AdviceDAO extends DBContext {

    public List<Advice> getAllAdvice() {
        List<Advice> list = new ArrayList<>();
        String sql = "SELECT a.*, acc.fullName FROM Advice a " +
                     "JOIN Account acc ON a.runnerID = acc.uID " +
                     "ORDER BY a.createdAt DESC";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Advice ad = new Advice();
                ad.setAdviceID(rs.getInt("adviceID"));
                ad.setRunnerID(rs.getInt("runnerID"));
                ad.setTitle(rs.getString("title"));
                ad.setMessage(rs.getString("message"));
                ad.setCreatedAt(rs.getTimestamp("createdAt"));

                // Gán account
                Account acc = new Account();
                acc.setuID(rs.getInt("runnerID"));
                acc.setFullName(rs.getString("fullName"));
                ad.setAccount(acc);

                list.add(ad);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Advice getAdviceById(int id) {
        String sql = "SELECT a.*, acc.fullName FROM Advice a " +
                     "JOIN Account acc ON a.runnerID = acc.uID WHERE a.adviceID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Advice ad = new Advice();
                ad.setAdviceID(rs.getInt("adviceID"));
                ad.setRunnerID(rs.getInt("runnerID"));
                ad.setTitle(rs.getString("title"));
                ad.setMessage(rs.getString("message"));
                ad.setCreatedAt(rs.getTimestamp("createdAt"));

                Account acc = new Account();
                acc.setuID(rs.getInt("runnerID"));
                acc.setFullName(rs.getString("fullName"));
                ad.setAccount(acc);

                return ad;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertAdvice(Advice ad) {
        String sql = "INSERT INTO Advice (runnerID, title, message, createdAt) VALUES (?, ?, ?, GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, ad.getRunnerID());
            st.setString(2, ad.getTitle());
            st.setString(3, ad.getMessage());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAdvice(Advice ad) {
        String sql = "UPDATE Advice SET title=?, message=? WHERE adviceID=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, ad.getTitle());
            st.setString(2, ad.getMessage());
            st.setInt(3, ad.getAdviceID());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAdvice(int id) {
        String sql = "DELETE FROM Advice WHERE adviceID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
