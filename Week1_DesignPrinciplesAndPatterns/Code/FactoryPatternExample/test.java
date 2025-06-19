package FactoryMethodPatternExample;

public class test {
    public static void main(String[] args) {
        DocumentFactory wordFactory=new WordDocuFactory();
        Document word=wordFactory.createDocument();
        word.open();

        DocumentFactory pdfFactory=new PdfDocuFactory();
        Document pdf=pdfFactory.createDocument();
        pdf.open();

        DocumentFactory excelFactory=new ExcelDocuFactory();
        Document excel=excelFactory.createDocument();
        excel.open();
    }
}
