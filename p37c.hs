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

ltruncated :: (Integral a) => a -> [a]
ltruncated n = n:(map toNum $ (tail . init . tails . toDigits) n)

-- Build up primes we know to be right-truncateable
list :: (Integral b) => b -> [b]
list n = n:(concatMap list $ filter isPrime $ map (+ (10 * n)) [1,3,7,9])

ans = sum $ filter ((all isPrime) . ltruncated) $ filter (>9) $ concatMap (list) [2,3,5,7]
