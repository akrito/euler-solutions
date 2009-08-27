module Main where
import qualified Euler as E
import qualified Data.Map as M
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

-- memoized isPrime?
isPrime n m
    | M.member n m = (M.findWithDefault False n m, m)
    | otherwise    = (E.isPrime n, M.insert n (E.isPrime n) m)

truncated n = n:(map E.toNum $ concatMap (tail . init) [tails ns, inits ns]) where ns = E.toDigits n

areTruncatedPrimes n m = _areTruncatedPrimes (truncated n) m
_areTruncatedPrimes [] m = (True, m)
_areTruncatedPrimes (n:ns) m
    | isNPrime == False = (False, newM)
    | otherwise         = _areTruncatedPrimes ns newM
    where
      (isNPrime, newM) = isPrime n m

findTruncatedPrimes sum count (n:ns) m
    | iP && (count == 10) = n:sum -- we're done!
    | iP                  = findTruncatedPrimes (n:sum) (count + 1) ns _m
    | otherwise           = findTruncatedPrimes sum count ns _m
    where
      (iP, _m) = areTruncatedPrimes n m

ans = sum $ findTruncatedPrimes [] 0 [2 * k + 1 | k <- [5..]] M.empty
