module Main where
import Euler
main = do print ans

ds = concatMap toDigits [0..]
ans = product $ map (\x -> ds!!(10^x)) [0..6]
