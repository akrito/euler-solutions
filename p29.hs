module Main where
import List

as = [2..100]
bs = [2..100]
sortedProducts = sort [a^b | a <- as, b <- bs]
uniqueProducts = foldr f [] sortedProducts

f x xs
    | xs == []        = [x]
    | head xs == x    = xs
    | otherwise       = concat([[x],xs])

main = do
  putStrLn $ show $ length $ uniqueProducts

