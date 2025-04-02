package com.example.game;

public class Exam {
	public static void printText(int time, String text) {
		try {
			Thread.sleep(time);
			System.out.println(text);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		printText(3000,"1");
		printText(2000,"2");
		printText(1000,"3");
	}
}
