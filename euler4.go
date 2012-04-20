/*
A palindromic number reads the same both ways. The largest palindrome made
from the product of two 2-digit numbers is 9009 = 91 99.

Find the largest palindrome made from the product of two 3-digit numbers.
*/

package main

import (
	"math/big"
	"fmt"
)

func digits(i int64) []int {

	out := []int{}
	in := big.NewInt(i)

	for int(in) > int(big.NewInt(0)) {
		mod := big.Mod(in, big.NewInt(10))
		out = append(int(mod))
		in = in - mod
		in = in / 10
	}
	return out
}

func main() {
	a := 1234
	fmt.Println(digits(a))
	// fmt.Println(math.Ceil(math.Log10(a)))
	// digits(a)
}
