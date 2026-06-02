module Main where

import Data.List.Split (splitOn)
import System.Environment (getArgs)

data YMD = YMD Int Int Int deriving (Show)

parseYMD :: [Char] -> Maybe YMD
parseYMD = listToYmd . splitOn "/"
  where
    listToYmd :: [String] -> Maybe YMD
    listToYmd (y : m : d : _) = Just $ YMD (read y) (read m) (read d)
    listToYmd _ = Nothing

main :: IO ()
main = do
  args <- getArgs

  case args of
    [dateString] -> do
      print (parseYMD dateString)
    _ -> do
      putStrLn "Usage: cabal run -- \"YYYY/MM/DD\""
