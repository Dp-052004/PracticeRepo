package FactoryMethodPatternExample;

public class PdfDocuFactory extends DocumentFactory{

    @Override
    public Document createDocument() {
        return new PdfDocument();
    } 
}
