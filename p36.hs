module Main where
import Euler
main = do
  putStrLn $ show $ ans

-- The decimal number, 585 = 1001001001 (binary), is palindromic in
-- both bases.  Find the sum of all numbers, less than one million,
-- which are palindromic in base 10 and base 2.  (Please note that the
-- palindromic number, in either base, may not include leading zeros.)

doublePalindromic n
    | last d10s == 0                             = False
    | reverse d10s == d10s && reverse d2s == d2s = True
    | otherwise                                  = False
    where
      d10s = toDigits n
      d2s = toDigitsBase n 2

odds n = [2 * x + 1 | x <- [0..floor ((n - 1)/ 2)]]

ans = sum $ filter doublePalindromic $ odds 1000000
