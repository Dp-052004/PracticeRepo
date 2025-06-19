package SingletonPatternExample;

public class Logger {
    private static Logger lg;
    private Logger(){
        System.out.println("Initialised Logger class");
    }

    public static Logger getLogger(){
        if(lg==null){
            lg=new Logger();
        }
        return lg;
    }
}
