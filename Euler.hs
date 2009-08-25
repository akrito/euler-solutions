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
