import java.util.*;
public class Forecast {
    public static double calculate(double initialValue,double rate,int time){
        if(time==0) return initialValue;
        else return calculate(initialValue,rate,time-1)*(1+rate);
    }

    public static void main(String[] args) {
        double initialValue;
        double rate;
        int time;
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter the initial value");
        initialValue=sc.nextDouble();
        System.out.println("Enter the initial value");
        rate=sc.nextDouble();
        System.out.println("Enter the initial value");
        time=sc.nextInt();
        double finalValue=calculate(initialValue,rate,time);
        System.out.printf("Future Value after %d years: Rs %.2f\n", time, finalValue);
    }
}
