package ECommerce_Search;

import java.util.*;

public class SearchTest {
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Shoes", "Fashion"),
            new Product(2, "Phone", "Electronics"),
            new Product(3, "Laptop", "Electronics"),
            new Product(4, "Tablet", "Electronics"),
            new Product(5,"Onion","Vegetables")
        };

        Product linear=Search.linearSearch(products,"ACXX");
        if(linear!=null){
            System.out.println("Search element found in the list through LS");
        }
        else{
            System.out.println("Search element not found in the list through LS");
        }

        Arrays.sort(products,Comparator.comparing(p->p.productName.toLowerCase()));
        Product binary=Search.binarySearch(products,"XXX");
        if(binary!=null){
            System.out.println("Search element found in the list through BS");
        }
        else{
            System.out.println("Search element not found in the list through BS");
        }
    }
}
