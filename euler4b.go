/*
A palindromic number reads the same both ways. The largest palindrome made
from the product of two 2-digit numbers is 9009 = 91 99.

Find the largest palindrome made from the product of two 3-digit numbers.
*/

package main

import (
	"math"
	"fmt"
)

func imod(x, y int) (z int) {
	z = int(math.Mod(float64(x), float64(y)))
	return
}

func reverse_digits(i int) (reverse []int) {
	for i > 0 {
		mod := imod(i, 10)
		reverse = append(reverse, mod)
		i = i - mod
		i = i / 10
	}
	return
}

func is_palindrome(a []int) bool {
	for i := 0; i < len(a) / 2; i++ {
		if a[i] != a[len(a) - 1 - i] {
			return false
		}
	}
	return true
}

func main() {
	max := 0
	for i := 1; i < 1000; i++ {
		for j := i; j < 1000; j++ {
			prod := i * j
			if is_palindrome(reverse_digits(prod)) && prod > max {
				max = prod
			}
		}
	}
	fmt.Println(max)
}
