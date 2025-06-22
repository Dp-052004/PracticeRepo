package ProxyPatternExample;

public class ProxyImage implements Image{
    private RealImage realImage;
    private String file;

    public ProxyImage(String file){
        this.file=file;
    }

    @Override
    public void display() {
        if(realImage==null){
            realImage=new RealImage(file);
        }
        realImage.display();
    }    
}
