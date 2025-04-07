package com.example.game;

import java.util.HashMap;
import java.util.Map;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;

class Test{
	
	private static Map<String,String> map = new HashMap<>();
	public static int i = 1;
	static {
		map.put("name", "홍길동");
	}
	
	public static Map<String,String> getMap(){
		return map;
	}
	public static void add(String key, String value) {
		map.put(key, value);
	}
}
public class Exam {
	public static void main(String[] args) {
		Map<String,String> map = new HashMap<>();
		map.putAll(Test.getMap());
		map.put("age", "22");
		System.out.println(map);//{name=홍길동, age=22}
		System.out.println(Test.getMap());//{name=홍길동}
	}

}
