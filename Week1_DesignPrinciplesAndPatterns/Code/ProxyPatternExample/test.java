package ProxyPatternExample;

public class test {
    public static void main(String[] args) {
        Image img1=new ProxyImage("photo1.jpg");
        Image img2=new ProxyImage("photo2.jpg");

        System.out.println("First call to display photo1.jpg:");
        img1.display();  // Loads + Displays

        System.out.println("\nSecond call to display photo1.jpg:");
        img1.display();  // Only Displays, already loaded (cached)

        System.out.println("\nFirst call to display photo2.jpg:");
        img2.display();  // Loads + Displays
    }
}
