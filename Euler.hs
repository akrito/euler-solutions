module Euler where
import qualified Data.IntSet as I
import Control.Monad.ST
import Data.Array.ST
import Data.Array

toDigitsBase n base
    | r == n    = [r]
    | otherwise = (toDigitsBase q base) ++ [r]
    where (q,r) = divMod n base

toDigits n = toDigitsBase n 10

toNumBase ds base
    | ds == []  = 0
    | otherwise = (last ds) + base * (toNumBase (reverse $ tail $ reverse ds) base )

toNum ds = toNumBase ds 10

isPrime :: (Integral a) => a -> Bool
isPrime n
    | n < 2     = False
    | otherwise = all ((/= 0) . (mod n)) [2..truncate (sqrt (fromIntegral n))]

-- slow method from http://www.haskell.org/haskellwiki/Prime_numbers
slowPrimes :: [Integer]
slowPrimes = 2:3:primes'
  where
    1:p:candidates = [6*k+r | k <- [0..], r <- [1,5]]
    primes'        = p : filter isPrime candidates
    isPrime n      = all (not . divides n) $ takeWhile (\p -> p*p <= n) primes'
    divides n p    = n `mod` p == 0

-- faster functional sieve. Would be faster if we mutated an array in-place
sieve n = [2,3,5] ++ (map toInteger $ I.toAscList $ worker 5 (I.fromDistinctAscList ps))
    where
      ps = filter (<=n) [6*k + r | k <- [1..n `div` 6], r <- [1,5]]
      worker x is
          | (x*x) > n = is
          | otherwise = worker (takeNext (x + 2) is) (removeMultiples x n is)

takeNext n is
    | I.member n is = n
    | otherwise     = takeNext (n + 2) is

removeMultiples x m is = is I.\\ (I.fromDistinctAscList $ takeWhile (<=m) $ map (x*) [x..])

-- imperative siege using a mutable array
msieve n = _msieve n

_msieve :: Int -> [Int]
_msieve n = runST $ do
              -- nums is a mutable array of possible primes
              nums <- newListArray (0,n-1) [x*(x `mod` 2) | x <- [0..]] :: ST s (STArray s Int Int)
              writeArray nums 1 0
              writeArray nums 2 2
              -- find primes and mark out multiples
              b <- getBounds nums
              sieveWorker 3 nums (snd b)
              getElems nums

sieveWorker n nums e = do
  if (n*n) > e then return () else
      do
        v <- readArray nums n
        if v /= 0 then mRemoveMultiples n nums e else return ()
        sieveWorker (n + 2) nums e

mRemoveMultiples n nums e = _mRemoveMultiples n nums e 0

_mRemoveMultiples n nums e i = do
  let ind = (n*(n + 2*i))
  if ind > e then return () else
      do
        markOut nums (n*(n + 2*i))
        _mRemoveMultiples n nums e  (i + 1)

markOut nums i = writeArray nums i 0

-- mermutations of a list
permute :: (Eq a) => [a] -> [[a]]
permute ns = _permute (length ns) [] ns
_permute n l r
    | length l == n = [l]
    | otherwise     = foldr (f l r) [] r
    where f l r d ans = ans ++ _permute n (l ++ [d]) (filter (\x -> x/= d) r)
