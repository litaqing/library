package com.page;


import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import java.io.Serializable;

@Repository
public class Page implements Serializable {
    private int page;//当前页面

    private int pageSize;//每页显示数量

    private int offset;



    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getOffset() {
        this.offset = (page -1)*pageSize;
        return offset;
    }

    public void setOffset(int offset) {
        this.offset = (page -1)*pageSize;
    }

    @Override
    public String toString() {
        return "Page{" +
                "page=" + page +
                ", pageSize=" + pageSize +
                ", offset=" + offset +
                '}';
    }
}