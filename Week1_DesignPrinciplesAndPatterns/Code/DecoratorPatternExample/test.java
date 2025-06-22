package DecoratorPatternExample;

public class test {
    public static void main(String[] args) {
        Notifier email=new EmailNotifier();
        email.send("Hello via Email!");
        System.out.println();

        Notifier emailsms=new SMSNotifierDecorator(new EmailNotifier());
        emailsms.send("Hello via Email and SMS!");
        System.out.println();

        Notifier totalmsg=new SlackNotifierDecorator(new SMSNotifierDecorator(new EmailNotifier()));
        totalmsg.send("Hello from Email, SMS and Slack");
    }
}
