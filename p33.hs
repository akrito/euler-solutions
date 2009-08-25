module Main where
import Euler
import List
main = do
  putStrLn $ show $ ans

-- The fraction 49/98 is a curious fraction, as an inexperienced
-- mathematician in attempting to simplify it may incorrectly believe
-- that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
--
-- We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
--
-- There are exactly four non-trivial examples of this type of fraction,
-- less than one in value, and containing two digits in the numerator and
-- denominator.
--
-- If the product of these four fractions is given in its lowest common
-- terms, find the value of the denominator.

-- all the fractions with two digits in the numerator and denominator
fractions = foldr (\z xs -> [(z,y) | y <- [z+1..99]] ++ xs) [] [10..99]

-- is there a number between 1 and 9 which exists in both num. and
-- denom., and when removed, is a reduction of the fraction?
--canReduce :: (Integral t, Fractional t) => (t, t) -> Bool
canReduce (n,d) = any (xCancelsAndReduces (toDigits n, toDigits d)) [1..9]

xCancelsAndReduces :: (Integral a) => ([a], [a]) -> a -> Bool
xCancelsAndReduces (n1,d1) x =
    (any (== x) n1) && (any (== x) d1) && ((toNum n1) * d2) == (n2 * (toNum d1))
    where
      n2 = toNum $ delete x n1
      d2 = toNum $ delete x d1

improper = foldr (\(a,b) (c, d) -> (a*c,b*d)) (1, 1) $ filter canReduce fractions
g = gcd (fst improper) (snd improper)
-- ugly hack 'cause I don't grok Haskell division
ans = truncate $ (fromIntegral (snd improper)) / (fromIntegral g)
