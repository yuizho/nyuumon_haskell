module Main where

import Control.Lens

main :: IO ()
main = do
  let value = (1, (2, 3, (999, 4, 5)), 6)
  print $ value ^. _2 . _3 . _1
