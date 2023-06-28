package com.yiddemoroom.model;


public class AGV extends AGVId{

    private int status;
    private String place;
    private String task;
    private int battery;
    private int signal;

    // Getter Methods 
    public int getStatus() {
        return status;
    }

    public String getPlace() {
        return place;
    }

    public String getTask() {
        return task;
    }

    public int getBattery() {
        return battery;
    }
    
    public int getSignal() {
        return signal;
    }


    // Setter Methods 
    public void setStatus(int status) {
        this.status = status;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public void setTask(String task) {
        this.task = task;
    }

    public void setBattery(int battery) {
        this.battery = battery;
    }

    public void setSignal(int signal) {
        this.signal = signal;
    }
    

    
}