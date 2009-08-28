module Main where
import List
import Euler
main = do print ans

mults i c n
    | c + len >= 9 = toDigits (n * i)
    | otherwise    = (toDigits (n * i)) ++ (mults (i + 1) (c + len) n)
    where len = length (toDigits (n * i))

isPandigital ns = (sort ns) == [1..9]

pandigitals = map toNum $ filter isPandigital $ map (mults 1 0) [1..9999]

ans = last $ sort $ pandigitals
