/* 
By considering the terms in the Fibonacci sequence whose values do not exceed
four million, find the sum of the even-valued terms.
*/

package main

import "fmt"

func main() {
	var  sum, fib1, fib2, fibtmp uint64 = 0, 1, 2, 0

	for fib2 < 4000000 {
		if fib2 % 2 == 0 {
			sum += fib2
		}
		fibtmp = fib2
		fib2 = fib1 + fib2
		fib1 = fibtmp
	}
	fmt.Println(sum)
}
