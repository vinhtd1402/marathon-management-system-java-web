package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.MarathonEvent;
import models.Sponsor;
import models.MarathonType;
import java.sql.Date;

public class MarathonEventDAO extends DBContext {

    PreparedStatement stm;
    ResultSet rs;

    // ✅ Lấy tất cả sự kiện
    public List<MarathonEvent> getAllEvent() {
        List<MarathonEvent> list = new ArrayList<>();
        try {
            String sql = """
                SELECT e.EventID, e.EventName, e.Location, e.StartDate, 
                       e.Fee, e.ImagePath, e.Description, e.HealthRequirement,
                       s.SponsorID, s.SponsorName, s.ContactInfo, s.Image AS SponsorImage,
                       t.TypeID, t.TypeName, t.Distance
                FROM MarathonEvent e
                JOIN Sponsor s ON e.SponsorID = s.SponsorID
                JOIN MarathonType t ON e.TypeID = t.TypeID
            """;

            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();

            while (rs.next()) {
                Sponsor sponsor = new Sponsor(
                        rs.getInt("SponsorID"),
                        rs.getString("SponsorName"),
                        rs.getString("ContactInfo"),
                        rs.getString("SponsorImage")
                );

                MarathonType type = new MarathonType(
                        rs.getInt("TypeID"),
                        rs.getString("TypeName"),
                        rs.getDouble("Distance")
                );

                MarathonEvent event = new MarathonEvent(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        rs.getString("Location"),
                        rs.getDate("StartDate"),
                        rs.getDouble("Fee"),
                        rs.getString("ImagePath"),
                        rs.getString("Description"),
                        rs.getString("HealthRequirement"),
                        sponsor,
                        type
                );

                list.add(event);
            }
        } catch (Exception ex) {
            System.out.println("getAllEvent: " + ex.getMessage());
        }
        return list;
    }

    // ✅ Thêm sự kiện mới
    public void addEvent(MarathonEvent e) {
        try {
            String sql = """
                INSERT INTO MarathonEvent 
                (EventName, Location, StartDate, Fee, ImagePath, Description, HealthRequirement, SponsorID, TypeID)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;
            stm = connection.prepareStatement(sql);

            stm.setString(1, e.getEventName());
            stm.setString(2, e.getLocation());
            stm.setDate(3, new java.sql.Date(e.getStartDate().getTime()));
            stm.setDouble(4, e.getFee());
            stm.setString(5, e.getImagePath());
            stm.setString(6, e.getDescription());
            stm.setString(7, e.getHealthRequirement());
            stm.setInt(8, e.getSponsor().getSponsorId());
            stm.setInt(9, e.getType().getTypeID());

            stm.executeUpdate();

        } catch (Exception ex) {
            System.out.println("insert Event: " + ex.getMessage());
        }
    }

    // ✅ Lấy sự kiện theo ID
    public MarathonEvent getEventById(int id) {
        try {
            String sql = """
                SELECT e.EventID, e.EventName, e.Location, e.StartDate, e.Fee, e.ImagePath,
                       e.Description, e.HealthRequirement,
                       s.SponsorID, s.SponsorName, s.ContactInfo, s.Image AS SponsorImage,
                       t.TypeID, t.TypeName, t.Distance
                FROM MarathonEvent e
                JOIN Sponsor s ON e.SponsorID = s.SponsorID
                JOIN MarathonType t ON e.TypeID = t.TypeID
                WHERE e.EventID = ?
            """;
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            rs = stm.executeQuery();

            if (rs.next()) {
                Sponsor sponsor = new Sponsor(
                        rs.getInt("SponsorID"),
                        rs.getString("SponsorName"),
                        rs.getString("ContactInfo"),
                        rs.getString("SponsorImage")
                );
                MarathonType type = new MarathonType(
                        rs.getInt("TypeID"),
                        rs.getString("TypeName"),
                        rs.getDouble("Distance")
                );

                return new MarathonEvent(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        rs.getString("Location"),
                        rs.getDate("StartDate"),
                        rs.getDouble("Fee"),
                        rs.getString("ImagePath"),
                        rs.getString("Description"),
                        rs.getString("HealthRequirement"),
                        sponsor,
                        type
                );
            }
        } catch (Exception e) {
            System.out.println("getEventById: " + e.getMessage());
        }
        return null;
    }

    // ✅ Cập nhật sự kiện
    public void updateEvent(MarathonEvent e) {
        try {
            String sql = """
                UPDATE MarathonEvent
                SET EventName=?, Location=?, StartDate=?, Fee=?, ImagePath=?, 
                    Description=?, HealthRequirement=?, SponsorID=?, TypeID=?
                WHERE EventID=?
            """;
            stm = connection.prepareStatement(sql);
            stm.setString(1, e.getEventName());
            stm.setString(2, e.getLocation());
            stm.setDate(3, new java.sql.Date(e.getStartDate().getTime()));
            stm.setDouble(4, e.getFee());
            stm.setString(5, e.getImagePath());
            stm.setString(6, e.getDescription());
            stm.setString(7, e.getHealthRequirement());
            stm.setInt(8, e.getSponsor().getSponsorId());
            stm.setInt(9, e.getType().getTypeID());
            stm.setInt(10, e.getEventID());
            stm.executeUpdate();
        } catch (Exception ex) {
            System.out.println("updateEvent: " + ex.getMessage());
        }
    }

    // ✅ Tìm kiếm sự kiện
    public List<MarathonEvent> searchEvent(String keyword) {
        List<MarathonEvent> list = new ArrayList<>();
        try {
            String sql = """
                SELECT e.EventID, e.EventName, e.Location, e.StartDate, e.Fee, e.ImagePath,
                       e.Description, e.HealthRequirement,
                       s.SponsorID, s.SponsorName, s.ContactInfo, s.Image AS SponsorImage,
                       t.TypeID, t.TypeName, t.Distance
                FROM MarathonEvent e
                JOIN Sponsor s ON e.SponsorID = s.SponsorID
                JOIN MarathonType t ON e.TypeID = t.TypeID
                WHERE e.EventName LIKE ? OR e.Location LIKE ?
            """;
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");
            rs = stm.executeQuery();

            while (rs.next()) {
                Sponsor sponsor = new Sponsor(
                        rs.getInt("SponsorID"),
                        rs.getString("SponsorName"),
                        rs.getString("ContactInfo"),
                        rs.getString("SponsorImage")
                );

                MarathonType type = new MarathonType(
                        rs.getInt("TypeID"),
                        rs.getString("TypeName"),
                        rs.getDouble("Distance")
                );

                MarathonEvent event = new MarathonEvent(
                        rs.getInt("EventID"),
                        rs.getString("EventName"),
                        rs.getString("Location"),
                        rs.getDate("StartDate"),
                        rs.getDouble("Fee"),
                        rs.getString("ImagePath"),
                        rs.getString("Description"),
                        rs.getString("HealthRequirement"),
                        sponsor,
                        type
                );

                list.add(event);
            }
        } catch (Exception ex) {
            System.out.println("searchEvent: " + ex.getMessage());
        }
        return list;
    }

    // ✅ Xóa sự kiện
// Giả sử bạn có EventDAO.java
public void deleteEvent(int eventId) {
    try {
               PreparedStatement ps1 = connection.prepareStatement(
            "DELETE FROM Payment WHERE RegID IN (SELECT RegID FROM Registration WHERE EventID = ?)");
        ps1.setInt(1, eventId);
        ps1.executeUpdate();

        // Xóa Registration
        PreparedStatement ps2 = connection.prepareStatement(
            "DELETE FROM Registration WHERE EventID = ?");
        ps2.setInt(1, eventId);
        ps2.executeUpdate();

        // Xóa Event
        PreparedStatement ps3 = connection.prepareStatement(
            "DELETE FROM MarathonEvent WHERE EventID = ?");
        ps3.setInt(1, eventId);
        ps3.executeUpdate();

    } catch (Exception e) {
    }
}
public List<MarathonEvent> searchEventsAdvanced(
        String keyword, Integer typeId, String location,
        java.sql.Date fromDate, java.sql.Date toDate,
        Double minFee, Double maxFee,
        Double minDistance, Double maxDistance) {
    List<MarathonEvent> list = new ArrayList<>();
    try {
        StringBuilder sql = new StringBuilder("""
            SELECT e.EventID, e.EventName, e.Location, e.StartDate, e.Fee, e.ImagePath,
                   e.Description, e.HealthRequirement,
                   s.SponsorID, s.SponsorName, s.ContactInfo, s.Image AS SponsorImage,
                   t.TypeID, t.TypeName, t.Distance
            FROM MarathonEvent e
            JOIN Sponsor s ON e.SponsorID = s.SponsorID
            JOIN MarathonType t ON e.TypeID = t.TypeID
            WHERE 1=1
        """);

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (e.EventName LIKE ? OR e.Location LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        if (location != null && !location.isBlank()) {
            sql.append(" AND e.Location LIKE ? ");
            params.add("%" + location.trim() + "%");
        }
        if (typeId != null) {
            sql.append(" AND t.TypeID = ? ");
            params.add(typeId);
        }
        if (fromDate != null) {
            sql.append(" AND e.StartDate >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append(" AND e.StartDate <= ? ");
            params.add(toDate);
        }
        if (minFee != null) {
            sql.append(" AND e.Fee >= ? ");
            params.add(minFee);
        }
        if (maxFee != null) {
            sql.append(" AND e.Fee <= ? ");
            params.add(maxFee);
        }
        if (minDistance != null) {
            sql.append(" AND t.Distance >= ? ");
            params.add(minDistance);
        }
        if (maxDistance != null) {
            sql.append(" AND t.Distance <= ? ");
            params.add(maxDistance);
        }
        sql.append(" ORDER BY e.StartDate ASC ");

        PreparedStatement ps = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Sponsor sponsor = new Sponsor(
                rs.getInt("SponsorID"),
                rs.getString("SponsorName"),
                rs.getString("ContactInfo"),
                rs.getString("SponsorImage")
            );
            MarathonType type = new MarathonType(
                rs.getInt("TypeID"),
                rs.getString("TypeName"),
                rs.getDouble("Distance")
            );
            MarathonEvent e = new MarathonEvent(
                rs.getInt("EventID"),
                rs.getString("EventName"),
                rs.getString("Location"),
                rs.getDate("StartDate"),
                rs.getDouble("Fee"),
                rs.getString("ImagePath"),
                rs.getString("Description"),
                rs.getString("HealthRequirement"),
                sponsor, type
            );
            list.add(e);
        }
    } catch (Exception ex) {
        System.out.println("searchEventsAdvanced: " + ex.getMessage());
    }
    return list;
}


}
