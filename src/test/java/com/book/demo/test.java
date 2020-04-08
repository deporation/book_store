package com.book.demo;

import java.util.stream.Collectors;

import org.junit.Test;
import org.junit.runner.RunWith;
public class test {

    @Test
    public void name() {
        String a = "abc";
        String s = a.chars().mapToObj(e->(char)e).map(e->e.toString()).map(e -> e = e+"%").collect(Collectors.joining());
        System.out.println(s);
    }
}