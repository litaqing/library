package com.pojo;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
@Repository
public class Book implements Serializable {
    private int id;
    private String name;
    private int number;
    private String detail;
    private String isLend;
    private int lendNumber;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public String getIsLend() {
        return isLend;
    }

    public void setIsLend(String isLend) {
        this.isLend = isLend;
    }

    public int getLendNumber() {
        return lendNumber;
    }

    public void setLendNumber(int lendNumber) {
        this.lendNumber = lendNumber;
    }

    @Override
    public String toString() {
        return "Book{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", number=" + number +
                ", detail='" + detail + '\'' +
                ", isLend='" + isLend + '\'' +
                ", lendNumber=" + lendNumber +
                '}';
    }
}
