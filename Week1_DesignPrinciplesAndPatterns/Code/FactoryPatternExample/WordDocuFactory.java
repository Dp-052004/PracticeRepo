package FactoryMethodPatternExample;

public class WordDocuFactory extends DocumentFactory{

    @Override
    public Document createDocument() {
        return new WordDocument();
    }   
}
