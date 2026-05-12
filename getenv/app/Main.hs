module Main where

import System.Environment

main :: IO ()
main = do
  let title = "Current User: "
  user <- getEnv "USER"
  putStrLn $ title ++ user
