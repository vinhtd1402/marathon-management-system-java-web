/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Administrator
 */
public class Sponsor {
      public int sponsorId;
    public String sponsorName;
    public String contactInfo;
    public String imagePath;

    public Sponsor() {
    }

    public Sponsor(int sponsorId, String sponsorName, String contactInfo, String imagePath) {
        this.sponsorId = sponsorId;
        this.sponsorName = sponsorName;
        this.contactInfo = contactInfo;
        this.imagePath = imagePath;
    }

    // Getters & Setters
    public int getSponsorId() {
        return sponsorId;
    }

    public void setSponsorId(int sponsorId) {
        this.sponsorId = sponsorId;
    }

    public String getSponsorName() {
        return sponsorName;
    }

    public void setSponsorName(String sponsorName) {
        this.sponsorName = sponsorName;
    }

    public String getContactInfo() {
        return contactInfo;
    }

    public void setContactInfo(String contactInfo) {
        this.contactInfo = contactInfo;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
