module Main where
import List

main = do
  putStrLn $ show $ length $ nub [a^b | a <- [2..100], b <- [2..100]]

