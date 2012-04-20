/* 
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?

How will we get prime factors?
What if we had a generator?
*/

package main

import (
	"fmt"
	"math"
)

func main() {
	num := float64(600851475143)
	factor := float64(64)

	for sqrt := math.Sqrt(num); factor < sqrt; {
		for math.Mod(num, factor) == 0 {
			fmt.Println(factor)
			num = num / factor
		}
		factor++
	}
}
