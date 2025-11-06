/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.util.Date;

/**
 *
 * @author Administrator
 */
public class MarathonEvent {
     public int eventID;
    public String eventName;
    public String location;
    public Date startDate;
    public String description;
    public double fee;
    public int sponsorID;
    public int typeID;
    public String createdBy;
    public Date createdAt;
    public String imagePath;
    public String healthRequirement;
    
    public MarathonEvent() {}
    
    public Sponsor sponsor;
    public MarathonType type;

    public MarathonEvent(int eventID, String eventName, String location, Date startDate, String description, double fee, 
            int sponsorID, int typeID, String createdBy, Date createdAt, String imagePath, String healthRequirement) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.location = location;
        this.startDate = startDate;
        this.description = description;
        this.fee = fee;
        this.sponsorID = sponsorID;
        this.typeID = typeID;
        this.createdBy = createdBy;
        this.createdAt = createdAt;
        this.imagePath = imagePath;
        this.healthRequirement = healthRequirement;
    }

  
        public MarathonEvent(int eventID, String eventName, String location, Date startDate,
                         double fee, String imagePath,String description, String healthRequirement, Sponsor sponsor, MarathonType type) {
        this.eventID = eventID;
        this.eventName = eventName;
        this.location = location;
        this.startDate = startDate;
        this.fee = fee;
        this.imagePath = imagePath;
        this.sponsor = sponsor;
        this.type = type;
        this.description = description;
        this.healthRequirement = healthRequirement;
    }

    public int getEventID() {
        return eventID;
    }

    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public int getSponsorID() {
        return sponsorID;
    }

    public void setSponsorID(int sponsorID) {
        this.sponsorID = sponsorID;
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getHealthRequirement() {
        return healthRequirement;
    }

    public void setHealthRequirement(String healthRequirement) {
        this.healthRequirement = healthRequirement;
    }

    public Sponsor getSponsor() {
        return sponsor;
    }

    public void setSponsor(Sponsor sponsor) {
        this.sponsor = sponsor;
    }

    public MarathonType getType() {
        return type;
    }

    public void setType(MarathonType type) {
        this.type = type;
    }

   
    
}
