package ProxyPatternExample;

public class RealImage implements Image{
    private String file;

    public RealImage(String file){
        this.file=file;
        loadFromServer(file);
    }

    private void loadFromServer(String file){
        System.out.println("Loading image from server:"+file);
    }

    @Override
    public void display() {
        System.out.println("Displaying image:"+file);
    }
}
