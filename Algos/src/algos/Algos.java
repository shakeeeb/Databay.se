/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package algos;

/**
 *
 * @author Terrell Mack
 */
public class Algos {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        int[] array = {8,5,3,5,6,1,3,45,745,1345,1,18,3,1,5};
        array = removeDuplicates(array);
        printArray(array);
        
        
    }
    
    public static int[] fairSplit(int[] array, int size) {
        
        int[][] t = new int[array.length][size + 1];
        int s = 0;
        for(int j = 0; j < array.length; j++) {
                s+=array[j];
            }
        
        int c = s / size;
        
        
        for(int i = 0; i < array.length; i++) {
            int sum = 0;
            for(int j = 0; j < array.length; j++) {
                sum+=array[j];
            }
            t[i][1] = sum - c;
            
            for(int k = 2; k < size; k++) {
                for(int l = 0; l < array.length - 1; l++) {
                    int tmin = 0;
                    if(i < 0) {
                    tmin = i;
                    }
                    
                    int max;
                    
                    t[l][k] =
                
                }
            
            }
        }
        
    }
    
    public static int[] removeDuplicates(int[] array) {
        int[] sortedArray = mergeSort(array);
        
        int[] uniqueArray = new int[array.length];
        uniqueArray[0] = sortedArray[0];
        int indexUnique = 1;
        
        for(int i = 1; i < sortedArray.length; i++) {
            if(sortedArray[i] != sortedArray[i-1]) {
                uniqueArray[indexUnique] = sortedArray[i];
                indexUnique++;
             
            }
        }
        
        return subArray(uniqueArray,0,indexUnique);
        
        
    }
    
    public static int[] mergeSort(int[] array) {
    
        // base case: size = 1
        if(array.length == 1) {
            return array;
        }
        
        int indexSplit = array.length / 2;
       
        // split array into 2
        int[] arrayA = mergeSort(subArray(array, 0, indexSplit));
        int[] arrayB = mergeSort(subArray(array, indexSplit, array.length));
        
        // place two arrays into new array
        int[] arrayC = new int[arrayA.length+arrayB.length];
        
        int indexA = 0;
        int indexB = 0;
        for(int i = 0; i < arrayA.length + arrayB.length; i++){
        
        if(indexA < arrayA.length && indexB < arrayB.length) {
        if(arrayA[indexA] < arrayB[indexB]) {
        arrayC[i] = arrayA[indexA];
        indexA++;
        } else {
        arrayC[i] = arrayB[indexB];
        indexB++;
        }
            
        } else {
          if(indexA >= arrayA.length) {
           while(i < arrayA.length + arrayB.length) {
               arrayC[i] = arrayB[indexB];
               indexB++;
               i++;
           }
          
          } else {
            while(i < arrayA.length + arrayB.length) {
               arrayC[i] = arrayA[indexA];
               indexA++;
               i++;
           }
          }
        
        }
        } 
        
    
    return arrayC;
    }
    
    public static int[] subArray(int[] array, int start, int end) {
    
    int[] subArray = new int[end-start];
    int index = 0;
    for(int i = start; i < end; i++) {
        subArray[index] = array[i];
        index++;
    }
   
    return subArray;
    }
    
    public static void printArray(int[] array) {
    for(int i = 0; i < array.length; i++) {
    System.out.print(array[i]+ " ");
    
    }
    }
}
