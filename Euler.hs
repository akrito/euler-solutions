module Euler where
import qualified Data.IntSet as I
import Control.Monad.ST
import Data.Array.ST
import Data.Array
import Data.List
import qualified Data.Array.Diff as D

toDigitsBase n base
    | r == n    = [r]
    | otherwise = (toDigitsBase q base) ++ [r]
    where (q,r) = divMod n base

toDigits n = toDigitsBase n 10

toNumBase ds base
    | ds == []  = 0
    | otherwise = (last ds) + base * (toNumBase (reverse $ tail $ reverse ds) base )

toNum ds = toNumBase ds 10

-- test for primality

isPrime :: (Integral a) => a -> Bool
isPrime 2       = True
isPrime n
    | n < 2     = False
    | otherwise = all ((/= 0) . (mod n)) $ 2:[3,5..truncate (sqrt (fromIntegral n))]

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

-- imperative sieve using a mutable array

msieve n = foldl f [] $ Data.Array.assocs $ arrSieve n
    where f xs (k,v) = if v then xs ++ [toInteger k] else xs

arrSieve n = runST $ do
              -- nums is a mutable array of possible primes
              nums <- newListArray (0,n-1) [(x `mod` 2) == 1| x <- [0..]] :: ST s (STUArray s Int Bool)
              writeArray nums 1 False
              writeArray nums 2 True
              -- find primes and mark out multiples
              --b <- getBounds nums
              --nums `seq` sieveWorker 3 nums $! snd b
              _sieveWorker n nums
              unsafeFreeze nums

_sieveWorker n nums = mapM_ mr [3..(floor (sqrt (fromIntegral n)))]
    where mr x = _mRemoveMultiples x nums (n - 1)

sieveWorker n nums e
    | (n*n) > e = return ()
    | otherwise =
        do
          v <- readArray nums n
          if v then _mRemoveMultiples n nums e else return ()
          let n2 = n + 2
          n2 `seq` sieveWorker n2 nums e

_mRemoveMultiples n nums e = mapM_ markOut [(n*(n + 2*i)) | i <- [0..((e `div` n) - n) `div` 2]]
    where markOut x = writeArray nums x False

mRemoveMultiples n nums e i
    | ind > e   = return ()
    | otherwise = writeArray nums i False >> (i1 `seq` mRemoveMultiples n nums e i1)
    where ind = (n*(n + 2*i))
          i1  = i + 1

-- sieve with Diff arrays

dsieve n = foldl f [] $ D.assocs $ _sieve n
    where f xs (k,v) = if v then xs ++ [toInteger k] else xs

_sieve n = worker 2 $ D.listArray (0,n-1) ([False,False] ++ repeat True) :: (D.DiffArray Int Bool)
    where
      worker x is
          | (x*x) >= n = is
          | otherwise  = worker (dTakeNext (x + 1) is) (dRemoveMultiples x n is)

dTakeNext n is
    | is D.! n       = n
    | otherwise  = dTakeNext (n + 1) is

dRemoveMultiples x m is = is D.// [(a, False) | a <- (takeWhile (<m) $ map (x*) [x..])]

-- permutations of a list
permute :: (Eq a) => [a] -> [[a]]
permute ns = _permute (length ns) [] ns
_permute n l r
    | length l == n = [l]
    | otherwise     = foldr (f l r) [] r
    where f l r d ans = ans ++ _permute n (l ++ [d]) (filter (\x -> x/= d) r)
