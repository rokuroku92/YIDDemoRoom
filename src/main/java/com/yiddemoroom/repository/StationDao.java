
package com.yiddemoroom.repository;

import com.yiddemoroom.model.Station;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class StationDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public List<Station> queryStations(){
        String sql = "SELECT * FROM station";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Station.class));
    }
}
