module Main where
import Euler
import List
main = do
  putStrLn $ show $ ans

--The number 3797 has an interesting property. Being prime itself, it
--is possible to continuously remove digits from left to right, and
--remain prime at each stage: 3797, 797, 97, and 7. Similarly we can
--work from right to left: 3797, 379, 37, and 3.
--
--Find the sum of the only eleven primes that are both truncatable
--from left to right and right to left.
--
--NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

isPrime n
    | n < 2          = False
    | otherwise      = all ((/= 0) . (mod n)) [2..truncate (sqrt (fromIntegral n))]

truncated n = (++) [n] $ map toNum $ (tail . init . tails . toDigits) n ++ (tail . init . inits . toDigits) n

ans = sum $ take 11 $ filter ((all isPrime) . truncated) [2 * k + 1 | k <- [5..]]
