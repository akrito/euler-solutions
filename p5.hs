module Main where
import qualified Data.Map as M
main = do print ans

ans = M.foldWithKey (\k v total -> (k^v) * total) 1 lcmFactors

lcmFactors = foldl (M.unionWith max) M.empty (map (factors M.empty) [2..20])

factors m 1 = m
factors m n = factors _m (n `div` firstF)
    where
      _m = M.insert firstF ((M.findWithDefault 0 firstF m) + 1) m
      firstF = head $ dropWhile ((/= 0) . (mod n)) [2..floor (sqrt (fromIntegral n))] ++ [n]
