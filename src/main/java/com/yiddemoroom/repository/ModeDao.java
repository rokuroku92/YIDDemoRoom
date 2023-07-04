
package com.yiddemoroom.repository;

import com.yiddemoroom.model.Mode;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ModeDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Mode> queryModes(){
        String sql = "SELECT * FROM `mode`";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Mode.class));
    }
}
