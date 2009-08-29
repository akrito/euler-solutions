module Euler where

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

permute ns = _permute (length ns) [] ns
_permute n l r
    | length l == n = [l]
    | otherwise     = foldr (f l r) [] r
    where f l r d ans = ans ++ _permute n (l ++ [d]) (filter (\x -> x/= d) r)
