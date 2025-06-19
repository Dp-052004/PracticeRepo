package ECommerce_Search;

public class Search {
    public static Product linearSearch(Product[] products, String name) {
        for (Product p : products) {
            if (p.productName.equalsIgnoreCase(name)) {
                return p;
            }
        }
        return null;
    }

    public static Product binarySearch(Product[] products,String name) {
        int left=0,right=products.length-1;
        while(left<=right){
            int mid=left+(right-left)/2;
            int compare=products[mid].productName.compareToIgnoreCase(name);
            if(compare==0) return products[mid];
            else if(compare<0) left=mid+1;
            else right=mid-1;
        }
        return null;
    }
}
