package com.yiddemoroom.model;

public class Task {
    private Long id;
    private String taskNumber;
    private String createTaskTime;
    private int agvId;
    private Integer startId;
    private Integer terminalId;
    private int modeId;
    private int status;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTaskNumber() {
        return taskNumber;
    }

    public void setTaskNumber(String taskNumber) {
        this.taskNumber = taskNumber;
    }

    public String getCreateTaskTime() {
        return createTaskTime;
    }

    public void setCreateTaskTime(String createTaskTime) {
        this.createTaskTime = createTaskTime;
    }

    public int getAgvId() {
        return agvId;
    }

    public void setAgvId(int agvId) {
        this.agvId = agvId;
    }

    public Integer getStartId() {
        return startId;
    }

    public void setStartId(Integer startId) {
        this.startId = startId;
    }

    public Integer getTerminalId() {
        return terminalId;
    }

    public void setTerminalId(Integer terminalId) {
        this.terminalId = terminalId;
    }

    public int getModeId() {
        return modeId;
    }

    public void setModeId(int modeId) {
        this.modeId = modeId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
    
}
