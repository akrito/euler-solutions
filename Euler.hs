{-# OPTIONS -O2 -optc-O -XBangPatterns #-}
module Euler where
import qualified Data.IntSet as I
import Control.Monad.ST
import Data.Array.ST
import Data.Array
import Data.Array.Base
import Data.List
import Data.Bits
import Data.Word
import qualified Data.Array.Diff as D
import qualified Data.Array.IO as O
import Control.Monad

-- conversions between int(eger)s and lists of int(eger)s

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

-- faster functional sieve. Uses a set of integers and wheel
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

-- monadic sieve using a ST array

msieve n = foldl f [] $ Data.Array.assocs $ arrSieve n
    where f !xs !(k,v) = if v then xs ++ [toInteger k] else xs

arrSieve n = runST $ do
              -- nums is a mutable array of possible primes
              nums <- newListArray (0,n-1) (repeat True) :: ST s (STUArray s Int Bool)
              writeArray nums 1 False
              -- find primes and mark out multiples
              _sieveWorker n nums
              unsafeFreeze nums

_sieveWorker !n !nums = do
  mapM_ mr $ 2:[3,5..(floor (sqrt (fromIntegral n)))]
    where mr !x = do
            v <- readArray nums x
            if v then _mRemoveMultiples x nums (n - 1) else return ()

_mRemoveMultiples n !nums !e = mapM_ markOut [(n*(n + i)) | i <- [0..((e `div` n) - n)]]
    where markOut !x = writeArray nums x False

-- functional sieve with Diff arrays

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

-- Don S's sieve

donSieve n = runST $ do
               -- a 0 in "a" is prime; a 1 is composite
               -- "n" is the max
               a <- newArray (2,n) 0 :: ST s (STUArray s Int Word8)
               go a n 2
               unsafeFreeze a

-- "a" is the array
-- "m" is the max
-- "n" is the number to try
go !a !m !n
    | n*n > m   = return ()
    | otherwise = do
          e <- unsafeRead a n
          if e == 0 then set (n*n)
                    else go a m (n+1)
    where
      set !j
          | j <= m    = unsafeWrite a j 1 >> set (j+n)
          | otherwise = go a m (n+1)

-- monadic sieve using an IO array

iosieve n = do
  marray <- ioarrSieve n
  assocs <- O.getAssocs marray
  return $ foldl f [] assocs
    where f xs (k,v) = if v then xs ++ [toInteger k] else xs

ioarrSieve n =
    do
      -- nums is a mutable array of possible primes
      nums <- O.newListArray (0,n-1) (repeat True) :: IO (O.IOUArray Int Bool)
      O.writeArray nums 1 False
      -- find primes and mark out multiples
      iosieveWorker n nums
      return nums

iosieveWorker !n !nums = do
  mapM_ mr $ 2:[3,5..(floor (sqrt (fromIntegral n)))]
    where mr !x = do
            v <- O.readArray nums x
            if v then iomRemoveMultiples x nums (n - 1) else return ()

iomRemoveMultiples n !nums !e = mapM_ markOut [(n*(n + i)) | i <- [0..((e `div` n) - n)]]
    where markOut !x = O.writeArray nums x False

