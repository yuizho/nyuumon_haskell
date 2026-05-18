module Main where

import Data.Time (getZonedTime)

targetPath :: FilePath
targetPath = "/tmp/sample.txt"

main :: IO ()
main = do
  now <- getZonedTime

  writeFile targetPath (show now)
  putStrLn =<< readFile targetPath
