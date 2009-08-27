module Main where
import Euler
import Data.List
main = do print ans

ans = foldl' f 0 [x * y | x <- reverse [100..999], y <- reverse [x..999]]
f z n
    | z >= n                     = z
    | nDigits == reverse nDigits = n
    | otherwise                  = z
    where nDigits = toDigits n
