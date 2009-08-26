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

truncated n = map toNum $ (tail . init . tails . toDigits) n ++ (tail . init . inits . toDigits) n

areTruncatedPrimes n = foldr (\x zs -> if not (isPrime x) then False else zs) True (truncated n)

findTruncatedPrimes sum count (n:ns)
    | not (isPrime n)     = findTruncatedPrimes sum count ns
    | iP && (count == 10) = sum ++ [n] -- we're done!
    | iP                  = findTruncatedPrimes (sum ++ [n]) (count + 1) ns
    | otherwise           = findTruncatedPrimes sum count ns
    where
      iP = areTruncatedPrimes n

ans = sum $ findTruncatedPrimes [] 0 [2 * k + 1 | k <- [5..]]
