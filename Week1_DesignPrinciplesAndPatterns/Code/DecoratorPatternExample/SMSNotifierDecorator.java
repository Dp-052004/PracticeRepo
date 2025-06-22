package DecoratorPatternExample;

public class SMSNotifierDecorator extends NotifierDecorator{
    public SMSNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String msg) {
        super.send(msg);
        System.out.println("SMS sent: " + msg);
    } 
}
