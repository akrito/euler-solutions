module Main where

corners 0 = (1, 1)
corners n = (s, l)
    where
      oldL = snd $ corners $ n - 1
      l = oldL + 8 * n
      s = l + 3 * oldL + 12 * n + fst (corners (n - 1))

main = do
  putStrLn $ show $ fst $ corners $ 500
