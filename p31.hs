module Main where

-- With at least mult of the first coin in the list, how many ways can
-- we make the target?

coins target denoms mult
    | denoms == []                 = 0
    | mult * currentCoin > target  = 0
    | mult * currentCoin == target = 1
    | otherwise                    =
        -- this multiplier with the rest of the coins
        (coins (target - (mult * currentCoin)) (tail denoms) 0) +
        -- increase the multiplier
        coins target denoms (mult + 1)
    where
      currentCoin = head denoms

main = do
  putStrLn $ show $ coins 200 [200,100,50,20,10,5,2,1] 0
