module Main where
import Euler
import List
main = do
  putStrLn $ show $ ans

-- 7 * 9! = 2,540,160 (7 digits). 8 * 9! is still 7 digits, so we
-- don't need to test further.
nums = [3..2540160]

-- What? There's no factorial in the Prelude?  Blatantly stolen from
-- http://www.willamette.edu/~fruehr/haskell/evolution.html
facs = scanl (*) 1 [1..]
fac n = facs !! n

checkSum n = n == (sum (map fac (toDigits n)))

ans = sum $ filter checkSum nums
