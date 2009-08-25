module Main where
import List
main = do
  putStrLn $ show $ ans

-- How many digits can a product contain?

-- Scenario 1
-- d1 + d2 = d3
-- d1 + d2 + d3 = 9
-- d1 + d2 + d1 + d2 = 9
-- 2d1 + 2d2 = 9
-- 2(d1 + d2) = 9
-- Can't be solved

-- Scenario 2
-- d1 + d2 - 1 = d3
-- d1 + d2 + d3 = 9
-- d1 + d2 + d1 + d2 - 1 = 9
-- 2(d1 + d2) - 1 = 9
-- 2(d1 + d2) = 10
-- d1 + d2 = 5
-- d1 can be between 1 and 4 digits

-- test: 39 + 186 = 7254

-- Return a list of all 5-digit permutations
aggPick5 :: (Eq a) => [a] -> [a] -> [([a], [a])]
aggPick5 l r
    | length l == 5 = [(l, r)]
    | otherwise     = foldr (f l r) [] r
    where f l r d ans = ans ++ aggPick5 (l ++ [d]) (filter (\x -> x/= d) r)

pandigitals ps
    | ps == []  = []
    | otherwise = filter (inR r) (map (\x -> splitAt x l) [1..4]) ++ pandigitals (tail ps)
    where
      p = head ps
      l = fst p
      r = snd p

inR rs (n1, n2) = sort (toDigits ((toNum n1) * (toNum n2))) == sort rs

toDigits :: (Integral t) => t -> [t]
toDigits n
    | r == n    = [r]
    | otherwise = toDigits q ++ [r]
    where (q,r) = divMod n 10

toNum ds
    | ds == []  = 0
    | otherwise = (last ds) + 10 * (toNum $ reverse $ tail $ reverse ds)

dups = map (\(x,y) -> (toNum x) * (toNum y)) (pandigitals $ aggPick5 [] [1..9])
ans = sum $ nub $ dups
