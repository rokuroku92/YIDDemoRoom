
package com.yiddemoroom.service;

import com.yiddemoroom.repository.TaskDao;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class SendTaskService {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private TaskDao taskDao;
    
    private String lastDate;
    private int serialNumber;
    
    public boolean insertTask(String time, String agv, String start, String terminal,String mode) {
        
        String lastTaskNumber = taskDao.selectLastTaskNumber();
        if (lastDate == null) {
            // 伺服器重啟
            lastDate = lastTaskNumber.substring(1, 9);
        }
        if (!lastDate.equals(time.substring(0, 8))){
            serialNumber = 1;
            lastDate = time.substring(0, 8);
        } else {
            // 日期未變更，流水號遞增
            serialNumber = Integer.parseInt(lastTaskNumber.substring(9));
            serialNumber++;
        }
        String taskNumber = "#" + lastDate + String.format("%04d", serialNumber);
        
        return taskDao.insertTask(taskNumber, time, agv, start, terminal, mode);
    }
}
