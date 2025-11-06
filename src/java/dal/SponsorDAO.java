/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import models.Sponsor;
/**
 *
 * @author Administrator
 */
public class SponsorDAO extends DBContext{
    PreparedStatement stm;
    ResultSet rs;
    
     public List<Sponsor> getAllSponsors() {
        List<Sponsor> list = new ArrayList<>();
        try {
            String strSQL = "SELECT SponsorID, SponsorName, ContactInfo, Image FROM Sponsor";
            stm = connection.prepareCall(strSQL);
            rs = stm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("SponsorID");
                String name = rs.getString("SponsorName");
                String contact = rs.getString("ContactInfo");
                String image = rs.getString("Image");
                Sponsor s = new Sponsor(id, name, contact, image);
                list.add(s);
            }
        } catch (Exception ex) {
            System.out.println("getAllSponsors: " + ex.getMessage());
        }
        return list;
    }

}
