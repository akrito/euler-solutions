module Main where
import qualified Data.Map as M
import Data.List
main = do print ans

isInt n = (fromIntegral $ floor n) == n

sides = [[a, b, sqrt(a**2 + b**2)] | a <- [1..333], b <- [a..(1000 - a) / 2]]

build = foldl' maybeRecordP M.empty sides

maybeRecordP m x
    | isInt (last x) = M.insertWith (+) (sum x) 1 m
    | otherwise      = m

max' k v (maxK, maxV)
    | v > maxV  = (k, v)
    | otherwise = (maxK, maxV)

ans = truncate $ fst $ M.foldWithKey max' (0.0, 0) build
