/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import models.MarathonType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Administrator
 */
public class EventTypeDAO extends DBContext{
    
    PreparedStatement stm;
    ResultSet rs;

public List<MarathonType> getAllType() {
    List<MarathonType> list = new ArrayList<>();
    try {
        String strSQL = "SELECT * FROM MarathonType"; // sửa tên bảng
        stm = connection.prepareStatement(strSQL);   // dùng prepareStatement thay vì prepareCall
        rs = stm.executeQuery();
        while (rs.next()) {
            int typeId = rs.getInt("TypeID");
            String typeName = rs.getString("TypeName");
            double distance = rs.getDouble("Distance");
            MarathonType type = new MarathonType(typeId, typeName, distance);
            list.add(type);
        }
    } catch (Exception ex) {
        System.out.println("getAllType: " + ex.getMessage());
    }
    return list;
}

}
