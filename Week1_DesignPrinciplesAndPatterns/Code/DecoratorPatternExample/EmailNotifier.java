package DecoratorPatternExample;

public class EmailNotifier implements Notifier{

    @Override
    public void send(String msg) {
        System.out.println("Email sent:"+msg);
    }
    
}
