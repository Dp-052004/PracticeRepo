package InventoryMgmt;

public class test {
    public static void main(String[] args) {
        Inventory inventory=new Inventory();

        Product p=new Product("PD1","Mobile Phone",30,45000);
        Product q=new Product("PD4","Laptop",20,60000);

        inventory.addProd(p);
        inventory.addProd(q);

        inventory.displayProds();

        System.out.println("Updated product 1");
        inventory.updateProd("PD1",12,30000);
        inventory.displayProds();

        System.out.println("Deleted product 2");
        inventory.deleteProd("PD1");
        inventory.displayProds();

    }
}
