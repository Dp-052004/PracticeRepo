package FactoryMethodPatternExample;

public class ExcelDocuFactory extends DocumentFactory{

    @Override
    public Document createDocument() {
        return new ExcelDocument();
    } 
}
