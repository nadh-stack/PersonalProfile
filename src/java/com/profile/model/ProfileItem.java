package com.profile.model;

import java.io.Serializable;

public class ProfileItem implements Serializable {

    private String name;
    private String studentId;
    private String program;
    private String email;
    private String hobbies;
    private String introduction;

    // Constructor
    public ProfileItem(String name, String studentId, String program, String email, String hobbies, String introduction) {
        this.name = name;
        this.studentId = studentId;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.introduction = introduction;
    }

    // Getters
    public String getName() { return name; }
    public String getStudentId() { return studentId; }
    public String getProgram() { return program; }
    public String getEmail() { return email; }
    public String getHobbies() { return hobbies; }
    public String getIntroduction() { return introduction; }

    // Setters
    public void setName(String name) { this.name = name; }
    public void setStudentId(String studentId) { this.studentId = studentId; }
    public void setProgram(String program) { this.program = program; }
    public void setEmail(String email) { this.email = email; }
    public void setHobbies(String hobbies) { this.hobbies = hobbies; }
    public void setIntroduction(String introduction) { this.introduction = introduction; }
}
