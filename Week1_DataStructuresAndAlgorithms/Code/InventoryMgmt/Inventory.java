package InventoryMgmt;

import java.util.HashMap;

public class Inventory {
    private HashMap<String,Product> mp;

    public Inventory(){
        mp=new HashMap<>();
    }

    public void addProd(Product p){
        mp.put(p.getProductId(), p);
    }

    public void deleteProd(String productId){
        mp.remove(productId);
    }

    public void updateProd(String productId, int quantity, double price){
        Product pr=mp.get(productId);
        if(pr!=null){
            pr.setQuantity(quantity);
            pr.setPrice(price);
        }
        else{
            System.out.println("Product not found");
        }
    }

    public void displayProds(){
        for(Product p:mp.values()){
            System.out.println(p);
        }
    }

    public Product searchProd(String productId){
        return mp.get(productId);
    }
}
