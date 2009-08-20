-- Find all numbers that can be written as the sum of the fifth powers
-- of their digits

-- Where do we stop? After how many digits?
-- 9^5 * 6 = 354294, so we'll stop there
-- No 7-digit number can have a 7-digit sum.

module Main where

applyFifthPowers targetNum digitPlace sumSoFar x =
    fifthPowers (targetNum + (x*10^digitPlace)) (digitPlace - 1) (sumSoFar + (x^5))

fifthPowers targetNum digitPlace sumSoFar =
    if targetNum > 354294
    then
        0
    else
        if digitPlace == 0
        then
            sum (map (addLastDigit targetNum sumSoFar) [0..9])
        else
            sum (map (applyFifthPowers targetNum digitPlace sumSoFar) [0..9])

addLastDigit targetNum sumSoFar x
    | (t == sumSoFar + x^5) && (t /= 1) = t
    | otherwise                         = 0
    where t = targetNum + x

main = do
  putStrLn $ show $ fifthPowers 0 5 0
