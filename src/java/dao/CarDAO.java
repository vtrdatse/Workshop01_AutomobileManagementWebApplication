/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import database.DatabaseConnectJDBC;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Car;

/**
 *
 * @author datvt
 */
public class CarDAO {

    private Connection connection = null;

    public CarDAO() {
        try {
            connection = DatabaseConnectJDBC.connect();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkExistedId(int carId) {
        String sql = "SELECT CarId FROM Cars WHERE CarId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, carId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public boolean create(Car car) {
        String sql = "INSERT INTO Cars (CarId, CarName, Manufacturer, Price, ReleasedYear) VALUES (?,?,?,?,?)";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, car.getId());
            statement.setString(2, car.getName());
            statement.setString(3, car.getManufacturer());
            statement.setBigDecimal(4, car.getPrice());
            statement.setInt(5, car.getReleasedYear());

            int affectedRow = statement.executeUpdate();
            if (affectedRow != 0) {
                return true;
            }
        } catch (SQLException exception) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, exception);
        }

        return false;
    }

    public boolean update(int carId, Car car) {
        String sql = "UPDATE Cars SET CarId = ?, CarName = ?, Manufacturer = ?, Price = ?, ReleasedYear = ? WHERE CarId = ?";

        try {
            if (car.getId() != carId) {
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, car.getId());
                statement.setString(2, car.getName());
                statement.setString(3, car.getManufacturer());
                statement.setBigDecimal(4, car.getPrice());
                statement.setInt(5, car.getReleasedYear());
                statement.setInt(6, carId);

                int affectedRow = statement.executeUpdate();
                if (affectedRow != 0) {
                    return true;
                }
            } else {
                sql = "UPDATE Cars SET CarName = ?, Manufacturer = ?, Price = ?, ReleasedYear = ? WHERE CarId = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setString(1, car.getName());
                statement.setString(2, car.getManufacturer());
                statement.setBigDecimal(3, car.getPrice());
                statement.setInt(4, car.getReleasedYear());
                statement.setInt(5, carId);

                int affectedRow = statement.executeUpdate();
                if (affectedRow != 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public boolean delete(int carId) {
        String sql = "DELETE FROM Cars WHERE CarID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, carId);

            int affectedRow = statement.executeUpdate();
            if (affectedRow != 0) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public Car getById(int carId) {
        Car car = null;
        String sql = "SELECT CarID, CarName, Manufacturer, Price, ReleasedYear FROM Cars WHERE CarID = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, carId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                car = new Car();
                car.setId(resultSet.getInt(1));
                car.setName(resultSet.getString(2));
                car.setManufacturer(resultSet.getString(3));
                car.setPrice(resultSet.getBigDecimal(4));
                car.setReleasedYear(resultSet.getInt(5));
            }
        } catch (SQLException exception) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, exception);
        } finally {
            return car;
        }
    }

    public List<Car> getList() {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT CarID, CarName, Manufacturer, Price, ReleasedYear FROM Cars";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Car car = new Car();
                car.setId(resultSet.getInt(1));
                car.setName(resultSet.getString(2));
                car.setManufacturer(resultSet.getString(3));
                car.setPrice(resultSet.getBigDecimal(4));
                car.setReleasedYear(resultSet.getInt(5));
                cars.add(car);
            }
        } catch (SQLException exception) {
            Logger.getLogger(CarDAO.class.getName()).log(Level.SEVERE, null, exception);
        } finally {
            return cars;
        }

    }
}
