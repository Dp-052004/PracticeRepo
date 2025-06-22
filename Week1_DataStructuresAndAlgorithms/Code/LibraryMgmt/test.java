package LibraryMgmt;

import java.util.*;

public class test {
    public static void main(String[] args) {
        Book[] books = {
            new Book(1, "The Alchemist", "Paulo Coelho"),
            new Book(2, "The Jungle Book", "Rudyard Kipling"),
            new Book(3, "Clean Code", "Robert Martin"),
            new Book(4, "A Tale of Two Cities", "Charles Dickens"),
            new Book(5, "1984", "George Orwell")
        };

        Book linear = LibrarySearch.linearSearch(books, "1984");
        if (linear != null) {
            System.out.println("Book found using Linear Search.");
        } else {
            System.out.println("Book not found using Linear Search.");
        }

        Arrays.sort(books, Comparator.comparing(b -> b.title.toLowerCase()));
        Book binary = LibrarySearch.binarySearch(books, "XXX");
        if (binary != null) {
            System.out.println("Book found using Binary Search.");
        } else {
            System.out.println("Book not found using Binary Search.");
        }
    }
}
