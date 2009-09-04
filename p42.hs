module Main where
import List
import Euler
import Text.CSV

-- n(n+1)/2 = Tn             -- for integer values of n
-- 2*Tn = n(n+1)             -- simplify
-- n^2 +n - 2*Tn = 0         -- solve for n, check n is an integer
-- (-1 + sqrt(8*Tn+1))/2 = n -- (ignoring negative and complex sultions for n)

isTri tn = (floor q) == (ceiling q)
    where q = (-1 + sqrt(8*(fromIntegral tn)+1))/2

count tris = length $ filter isTri $ map wordToSum tris

wordToSum s = sum $ map ((-64 +) . fromEnum) s

main = do
  Right words <- parseCSVFromFile "words.txt"
  print $ count $ head words
  return ()
