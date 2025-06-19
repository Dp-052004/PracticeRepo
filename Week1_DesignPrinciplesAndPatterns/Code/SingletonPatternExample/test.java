package SingletonPatternExample;

public class test {
    
    public static void main(String[] args) {
        Logger obj1=Logger.getLogger();
        Logger obj2=Logger.getLogger();
        System.out.println(obj1.hashCode());
        System.out.println(obj2.hashCode());

        if(obj1==obj2){
            System.out.println("SAME INSTANCE");
        }
        else{
            System.out.println("DIFFERENT INSTANCE");
        }
    }
}
