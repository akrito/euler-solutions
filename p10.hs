module Main where
import Euler
import qualified Data.IntSet as I
main = do
  primes <- iosieve 100000
  print $ sum primes
