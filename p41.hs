module Main where
import List
import Euler
main = do print ans

ans = maximum $ filter isPrime $ map toNum $ (permute [1..7]) ++ (permute [1..4])
