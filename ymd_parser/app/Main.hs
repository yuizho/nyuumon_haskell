{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Attoparsec.Text hiding (take)
import Data.List.Split (splitOn)
import Data.Text (Text)
import qualified Data.Text as T
import System.Environment (getArgs)

data YMD = YMD Int Int Int deriving (Show)

ymdParser :: Parser YMD
ymdParser =
  YMD <$> decimal <* char '/' <*> decimal <* char '/' <*> decimal <* endOfInput

parseYMD :: Text -> Maybe YMD
parseYMD input = case parseOnly ymdParser input of
  Right ymd -> Just ymd
  Left _ -> Nothing

main :: IO ()
main = do
  args <- getArgs

  case args of
    [dateString] -> do
      let textInput = T.pack dateString
      case parseYMD textInput of
        Just ymd -> print ymd
        Nothing -> putStrLn "YYYY/MM/DD形式で入力してください"
    _ -> do
      putStrLn "Usage: cabal run -- \"YYYY/MM/DD\""
