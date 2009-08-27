module Main where
import Euler
import List
main = do
  putStrLn $ show $ ans

ss n = n * ((m * (m + 1)) `div` 2) where m = 999 `div` (abs n)
ans = sum $ map ss [3,5,-15]
