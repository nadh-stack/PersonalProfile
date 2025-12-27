package com.profile.model;

import java.io.Serializable;

public class ProfileBean implements Serializable {

    private String studentId;
    private String name;
    private String program;
    private String email;
    private String hobbies;
    private String introduction;

    public ProfileBean() {
    }

    public ProfileBean(String studentId, String name, String program,
            String email, String hobbies, String introduction) {
        this.studentId = studentId;
        this.name = name;
        this.program = program;
        this.email = email;
        this.hobbies = hobbies;
        this.introduction = introduction;
    }

    //Getters and setters
    public String getStudentId() {
        return studentId;
    }
    public String getName() {
        return name;
    }
    public String getProgram() {
        return program;
    }
    public String getEmail() {
        return email;
    }
    public String getHobbies() {
        return hobbies;
    }
    public String getIntroduction() {
        return introduction;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setProgram(String program) {
        this.program = program;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setHobbies(String hobbies) {
        this.hobbies = hobbies;
    }
    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }
}
