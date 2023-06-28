
package com.yiddemoroom.repository;

import com.yiddemoroom.model.AGVId;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
    
@Repository
public class AGVIdDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<AGVId> queryAGVList(){
        String sql = "SELECT * FROM agv";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(AGVId.class));
    }
    
}
