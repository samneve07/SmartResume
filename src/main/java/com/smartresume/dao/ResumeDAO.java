package com.smartresume.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.smartresume.util.DBConnection;

public class ResumeDAO {

    public int createResume(
            int userId,
            String resumeTitle,
            String fullName,
            String email,
            String phone,
            String location,
            String linkedin,
            String github,
            String summary,
            String education,
            String skills,
            String projects,
            String experience,
            String certifications,
            String languages,
            String achievements,
            String interests,
            String profilePhoto,
            String template,
            String themeColor) {

        String sql =
                "INSERT INTO resumes " +
                "(user_id,resume_title,full_name,email,phone,location,linkedin,github,summary," +
                "education,skills,projects,experience,certifications,languages,achievements," +
                "interests,profile_photo,template,theme_color) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            setResumeParameters(
                    statement,
                    userId,
                    resumeTitle,
                    fullName,
                    email,
                    phone,
                    location,
                    linkedin,
                    github,
                    summary,
                    education,
                    skills,
                    projects,
                    experience,
                    certifications,
                    languages,
                    achievements,
                    interests,
                    profilePhoto,
                    template,
                    themeColor
            );

            if (statement.executeUpdate() == 0) {
                return -1;
            }

            try (ResultSet keys = statement.getGeneratedKeys()) {

                if (keys.next()) {
                    return keys.getInt(1);
                }
            }

        } catch (SQLException e) {
    System.err.println("SMARTRESUME CREATE RESUME FAILED");
    System.err.println("SQL State: " + e.getSQLState());
    System.err.println("Error Code: " + e.getErrorCode());
    e.printStackTrace();
        }

        return -1;
    }


    public boolean updateResume(
            int resumeId,
            int userId,
            String resumeTitle,
            String fullName,
            String email,
            String phone,
            String location,
            String linkedin,
            String github,
            String summary,
            String education,
            String skills,
            String projects,
            String experience,
            String certifications,
            String languages,
            String achievements,
            String interests,
            String profilePhoto,
            String template,
            String themeColor) {

        String sql =
                "UPDATE resumes SET " +
                "resume_title=?,full_name=?,email=?,phone=?,location=?,linkedin=?,github=?,summary=?," +
                "education=?,skills=?,projects=?,experience=?,certifications=?,languages=?," +
                "achievements=?,interests=?,profile_photo=?,template=?,theme_color=? " +
                "WHERE resume_id=? AND user_id=?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            int i = 1;

            statement.setString(i++, resumeTitle);
            statement.setString(i++, fullName);
            statement.setString(i++, email);
            statement.setString(i++, phone);
            statement.setString(i++, location);
            statement.setString(i++, linkedin);
            statement.setString(i++, github);
            statement.setString(i++, summary);
            statement.setString(i++, education);
            statement.setString(i++, skills);
            statement.setString(i++, projects);
            statement.setString(i++, experience);
            statement.setString(i++, certifications);
            statement.setString(i++, languages);
            statement.setString(i++, achievements);
            statement.setString(i++, interests);
            statement.setString(i++, profilePhoto);
            statement.setString(i++, template);
            statement.setString(i++, themeColor);

            statement.setInt(i++, resumeId);
            statement.setInt(i, userId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    private void setResumeParameters(
            PreparedStatement statement,
            int userId,
            String resumeTitle,
            String fullName,
            String email,
            String phone,
            String location,
            String linkedin,
            String github,
            String summary,
            String education,
            String skills,
            String projects,
            String experience,
            String certifications,
            String languages,
            String achievements,
            String interests,
            String profilePhoto,
            String template,
            String themeColor) throws SQLException {

        statement.setInt(1, userId);
        statement.setString(2, resumeTitle);
        statement.setString(3, fullName);
        statement.setString(4, email);
        statement.setString(5, phone);
        statement.setString(6, location);
        statement.setString(7, linkedin);
        statement.setString(8, github);
        statement.setString(9, summary);
        statement.setString(10, education);
        statement.setString(11, skills);
        statement.setString(12, projects);
        statement.setString(13, experience);
        statement.setString(14, certifications);
        statement.setString(15, languages);
        statement.setString(16, achievements);
        statement.setString(17, interests);
        statement.setString(18, profilePhoto);
        statement.setString(19, template);
        statement.setString(20, themeColor);
    }


    public List<ResumeData> getResumesByUserId(int userId) {

        List<ResumeData> resumes = new ArrayList<>();

        String sql =
                "SELECT * FROM resumes " +
                "WHERE user_id=? " +
                "ORDER BY updated_at DESC";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, userId);

            try (ResultSet rs = statement.executeQuery()) {

                while (rs.next()) {
                    resumes.add(createResumeData(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return resumes;
    }


    public ResumeData getResumeById(
            int resumeId,
            int userId) {

        String sql =
                "SELECT * FROM resumes " +
                "WHERE resume_id=? AND user_id=?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, resumeId);
            statement.setInt(2, userId);

            try (ResultSet rs = statement.executeQuery()) {

                if (rs.next()) {
                    return createResumeData(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    public boolean deleteResume(
            int resumeId,
            int userId) {

        String sql =
                "DELETE FROM resumes " +
                "WHERE resume_id=? AND user_id=?";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, resumeId);
            statement.setInt(2, userId);

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public int duplicateResume(
            int resumeId,
            int userId) {

        ResumeData original =
                getResumeById(resumeId, userId);

        if (original == null) {
            return -1;
        }

        return createResume(
                userId,
                original.getResumeTitle() + " Copy",
                original.getFullName(),
                original.getEmail(),
                original.getPhone(),
                original.getLocation(),
                original.getLinkedin(),
                original.getGithub(),
                original.getSummary(),
                original.getEducation(),
                original.getSkills(),
                original.getProjects(),
                original.getExperience(),
                original.getCertifications(),
                original.getLanguages(),
                original.getAchievements(),
                original.getInterests(),
                original.getProfilePhoto(),
                original.getTemplate(),
                original.getThemeColor()
        );
    }


    private ResumeData createResumeData(
            ResultSet rs) throws SQLException {

        return new ResumeData(

                rs.getInt("resume_id"),
                rs.getInt("user_id"),

                rs.getString("resume_title"),
                rs.getString("full_name"),
                rs.getString("email"),
                rs.getString("phone"),
                rs.getString("location"),

                rs.getString("linkedin"),
                rs.getString("github"),

                rs.getString("summary"),
                rs.getString("education"),
                rs.getString("skills"),
                rs.getString("projects"),
                rs.getString("experience"),

                rs.getString("certifications"),
                rs.getString("languages"),

                rs.getString("achievements"),
                rs.getString("interests"),

                rs.getString("profile_photo"),

                rs.getString("template"),
                rs.getString("theme_color"),

                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }


    public static class ResumeData {

        private final int resumeId;
        private final int userId;

        private final String resumeTitle;
        private final String fullName;
        private final String email;
        private final String phone;
        private final String location;

        private final String linkedin;
        private final String github;

        private final String summary;
        private final String education;
        private final String skills;
        private final String projects;
        private final String experience;

        private final String certifications;
        private final String languages;

        private final String achievements;
        private final String interests;

        private final String profilePhoto;

        private final String template;
        private final String themeColor;

        private final java.sql.Timestamp createdAt;
        private final java.sql.Timestamp updatedAt;


        public ResumeData(
                int resumeId,
                int userId,

                String resumeTitle,
                String fullName,
                String email,
                String phone,
                String location,

                String linkedin,
                String github,

                String summary,
                String education,
                String skills,
                String projects,
                String experience,

                String certifications,
                String languages,

                String achievements,
                String interests,

                String profilePhoto,

                String template,
                String themeColor,

                java.sql.Timestamp createdAt,
                java.sql.Timestamp updatedAt) {

            this.resumeId = resumeId;
            this.userId = userId;

            this.resumeTitle = resumeTitle;
            this.fullName = fullName;
            this.email = email;
            this.phone = phone;
            this.location = location;

            this.linkedin = linkedin;
            this.github = github;

            this.summary = summary;
            this.education = education;
            this.skills = skills;
            this.projects = projects;
            this.experience = experience;

            this.certifications = certifications;
            this.languages = languages;

            this.achievements = achievements;
            this.interests = interests;

            this.profilePhoto = profilePhoto;

            this.template = template;
            this.themeColor = themeColor;

            this.createdAt = createdAt;
            this.updatedAt = updatedAt;
        }


        public int getResumeId() {
            return resumeId;
        }

        public int getUserId() {
            return userId;
        }

        public String getResumeTitle() {
            return resumeTitle;
        }

        public String getFullName() {
            return fullName;
        }

        public String getEmail() {
            return email;
        }

        public String getPhone() {
            return phone;
        }

        public String getLocation() {
            return location;
        }

        public String getLinkedin() {
            return linkedin;
        }

        public String getGithub() {
            return github;
        }

        public String getSummary() {
            return summary;
        }

        public String getEducation() {
            return education;
        }

        public String getSkills() {
            return skills;
        }

        public String getProjects() {
            return projects;
        }

        public String getExperience() {
            return experience;
        }

        public String getCertifications() {
            return certifications;
        }

        public String getLanguages() {
            return languages;
        }

        public String getAchievements() {
            return achievements;
        }

        public String getInterests() {
            return interests;
        }

        public String getProfilePhoto() {
            return profilePhoto;
        }

        public String getTemplate() {
            return template;
        }

        public String getThemeColor() {
            return themeColor;
        }

        public java.sql.Timestamp getCreatedAt() {
            return createdAt;
        }

        public java.sql.Timestamp getUpdatedAt() {
            return updatedAt;
        }
    }
}
