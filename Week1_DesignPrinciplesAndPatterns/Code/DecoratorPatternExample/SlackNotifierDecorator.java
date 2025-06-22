package DecoratorPatternExample;

public class SlackNotifierDecorator extends NotifierDecorator{
     public SlackNotifierDecorator(Notifier notifier) {
        super(notifier);
    }

    @Override
    public void send(String msg) {
        super.send(msg); // send the previous notification(s)
        System.out.println("Slack message sent: " + msg);
    }
}
