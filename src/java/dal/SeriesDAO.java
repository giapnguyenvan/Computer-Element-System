package dal;

import model.Series;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SeriesDAO {
    
    public List<Series> getAllSeries() {
        DBContext db = DBContext.getInstance();
        List<Series> series = new ArrayList<>();
        String sql = "SELECT * FROM series ORDER BY name";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Series s = new Series();
                s.setSeriesId(rs.getInt("series_id"));
                s.setBrandId(rs.getInt("brand_id"));
                s.setName(rs.getString("name"));
                s.setComponentTypeId(rs.getInt("component_type_id"));
                s.setDescription(rs.getString("description"));
                series.add(s);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return series;
    }
    
    public List<Series> getSeriesByBrand(int brandId) {
        DBContext db = DBContext.getInstance();
        List<Series> series = new ArrayList<>();
        String sql = "SELECT * FROM series WHERE brand_id = ? ORDER BY name";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, brandId);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Series s = new Series();
                s.setSeriesId(rs.getInt("series_id"));
                s.setBrandId(rs.getInt("brand_id"));
                s.setName(rs.getString("name"));
                s.setComponentTypeId(rs.getInt("component_type_id"));
                s.setDescription(rs.getString("description"));
                series.add(s);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return series;
    }
    
    public Series getSeriesById(int seriesId) {
        DBContext db = DBContext.getInstance();
        String sql = "SELECT * FROM series WHERE series_id = ?";
        try {
            PreparedStatement statement = db.getConnection().prepareStatement(sql);
            statement.setInt(1, seriesId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                Series s = new Series();
                s.setSeriesId(rs.getInt("series_id"));
                s.setBrandId(rs.getInt("brand_id"));
                s.setName(rs.getString("name"));
                s.setComponentTypeId(rs.getInt("component_type_id"));
                s.setDescription(rs.getString("description"));
                return s;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }
} 