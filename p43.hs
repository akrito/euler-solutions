module Main where
import List
import Euler hiding (permute, _permute)
import Text.CSV

ps = [0,0,0,2,3,5,7,11,13,17]

permute ns = _permute [] ns

_permute l [] = [l]
_permute l r  = foldr f [] r
    where f digit list =
              let cont = (list ++ _permute (l ++ [digit]) (filter (\x -> x/= digit) r))
                  llen = length l
                  next3 = (drop (llen - 2) l) ++ [digit]
                  canDiv = (toNum next3) `mod` (ps!!llen) == 0
              in
                if llen < 3 || canDiv then cont else list

main = do print $ sum $ map toNum $ permute [0..9]
