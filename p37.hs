module Main where
import Euler
import qualified Data.Map as M
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

isPrime n m
    | M.member n m = (M.findWithDefault False n m, m)
    | otherwise    = (_isPrime n, M.insert n (_isPrime n) m)

_isPrime :: (Integral a) => a -> Bool
_isPrime n
    | n < 2        = False
    | otherwise  = not $ any (\x -> (n `mod` x) == 0) [2..truncate (sqrt (fromIntegral n))]

truncateLeft  (_:[]) = []
truncateLeft  (_:ns) = [ns] ++ (truncateLeft ns)
truncateRight (_:[]) = []
truncateRight ns     = [init ns] ++ (truncateRight (init ns))
truncated n = [n] ++ (map toNum $ truncateLeft (toDigits n) ++ truncateRight (toDigits n))

areTruncatedPrimes n m = _areTruncatedPrimes (truncated n) m
_areTruncatedPrimes [] m = (True, m)
_areTruncatedPrimes (n:ns) m
    | isNPrime == False = (False, newM)
    | otherwise         = _areTruncatedPrimes ns newM
    where
      (isNPrime, newM) = isPrime n m

findTruncatedPrimes sum count (n:ns) m
    | iP && (count == 10) = sum ++ [n] -- we're done!
    | iP                  = findTruncatedPrimes (sum ++ [n]) (count + 1) ns _m
    | otherwise           = findTruncatedPrimes sum count ns _m
    where
      (iP, _m) = areTruncatedPrimes n m

ans = sum $ findTruncatedPrimes [] 0 [2 * k + 1 | k <- [5..]] M.empty
