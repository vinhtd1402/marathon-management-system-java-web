/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Administrator
 */
public class EventDetail {
    public MarathonEvent marathonEvent;
    public MarathonType eventType;
    public Sponsor sponsor;

    public EventDetail() {
    }

    public EventDetail(MarathonEvent marathonEvent, MarathonType eventType, Sponsor sponsor) {
        this.marathonEvent = marathonEvent;
        this.eventType = eventType;
        this.sponsor = sponsor;
    }

    public MarathonEvent getMarathonEvent() {
        return marathonEvent;
    }

    public void setMarathonEvent(MarathonEvent marathonEvent) {
        this.marathonEvent = marathonEvent;
    }

    public MarathonType getEventType() {
        return eventType;
    }

    public void setEventType(MarathonType eventType) {
        this.eventType = eventType;
    }

    public Sponsor getSponsor() {
        return sponsor;
    }

    public void setSponsor(Sponsor sponsor) {
        this.sponsor = sponsor;
    }
    
}
