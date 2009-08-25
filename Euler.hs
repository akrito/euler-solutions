module Euler where

toDigits :: (Integral t) => t -> [t]
toDigits n
    | r == n    = [r]
    | otherwise = toDigits q ++ [r]
    where (q,r) = divMod n 10

toNum ds
    | ds == []  = 0
    | otherwise = (last ds) + 10 * (toNum $ reverse $ tail $ reverse ds)

