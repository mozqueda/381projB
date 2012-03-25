package bubblesort;

public class BubbleSort {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int[] array = {5, 1, 4, 2, 8};
		b_sort(array);
		for(int i = 0; i < array.length; i++){
			System.out.println(array[i]);
		}
		

	}
	
	public static void b_sort(int[] arr){
		boolean swapped = true;
	      int n = arr.length;
	      int tmp;
	      while (swapped) {
	            swapped = false;
	            n--;
	            for (int i = 0; i < n; i++) {                                       
	                //int left = arr[i];
	                //int right = arr[i+1];
	            	if (arr[i] > arr[i + 1]) {                          
	                        tmp = arr[i];
	                        arr[i] = arr[i + 1];
	                        arr[i + 1] = tmp;
	                        swapped = true;
	                  }
	            }                
	      }
		
		
	}

}
