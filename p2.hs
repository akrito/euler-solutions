module Main where
import Euler
import List
main = do print $ show $ ans

fibs one two = (one + two):(fibs two (one + two))

ans = sum $ filter (\x -> (x `mod` 2) == 0) $ takeWhile (<4000000) (fibs 1 1)
