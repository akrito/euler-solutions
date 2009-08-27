module Main where
main = do print ans

-- find the first prime factor of n, including n
factors n
    | head fs == n = n
    | otherwise    = factors (n `div` (head fs))
    where fs = dropWhile ((/= 0) . (mod n)) [2..floor (sqrt (fromIntegral n))] ++ [n]

ans = factors 600851475143
