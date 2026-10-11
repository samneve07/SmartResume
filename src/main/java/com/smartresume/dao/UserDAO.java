
package com.smartresume.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.smartresume.util.DBConnection;

public class UserDAO {

    public boolean emailExists(String email) throws SQLException {
        String sql = "SELECT user_id FROM users WHERE email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public boolean emailExistsForAnotherUser(String email, int userId)
            throws SQLException {

        String sql = "SELECT user_id FROM users WHERE email = ? AND user_id <> ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);
            statement.setInt(2, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                return resultSet.next();
            }
        }
    }

    public boolean registerUser(String fullName, String email,
                                String hashedPassword) throws SQLException {

        String sql = "INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setString(3, hashedPassword);

            return statement.executeUpdate() > 0;
        }
    }

    public UserData getUserByEmail(String email) throws SQLException {
        String sql = "SELECT user_id, full_name, email, password FROM users WHERE email = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, email);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new UserData(
                        resultSet.getInt("user_id"),
                        resultSet.getString("full_name"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                    );
                }
            }
        }

        return null;
    }

    public UserData getUserById(int userId) throws SQLException {
        String sql = "SELECT user_id, full_name, email, password FROM users WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return new UserData(
                        resultSet.getInt("user_id"),
                        resultSet.getString("full_name"),
                        resultSet.getString("email"),
                        resultSet.getString("password")
                    );
                }
            }
        }

        return null;
    }

    public boolean updateProfile(int userId, String fullName, String email)
            throws SQLException {

        String sql = "UPDATE users SET full_name = ?, email = ? WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, fullName);
            statement.setString(2, email);
            statement.setInt(3, userId);

            return statement.executeUpdate() > 0;
        }
    }

    public boolean updatePassword(int userId, String hashedPassword)
            throws SQLException {

        String sql = "UPDATE users SET password = ? WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, hashedPassword);
            statement.setInt(2, userId);

            return statement.executeUpdate() > 0;
        }
    }

    public static class UserData {
        private final int userId;
        private final String fullName;
        private final String email;
        private final String password;

        public UserData(int userId, String fullName, String email, String password) {
            this.userId = userId;
            this.fullName = fullName;
            this.email = email;
            this.password = password;
        }

        public int getUserId() {
            return userId;
        }

        public String getFullName() {
            return fullName;
        }

        public String getEmail() {
            return email;
        }

        public String getPassword() {
            return password;
        }
    }
}
