{-# LANGUAGE OverloadedStrings #-}

module Main where

import Control.Applicative
import Data.Attoparsec.Text hiding (take)
import Data.Text (Text)
import qualified Data.Text as T

data Term = Add Expr deriving (Show)

data Expr = ExTerm Double Term | ExEnd Double deriving (Show)

eval :: Expr -> Double
eval (ExEnd val) = val
eval (ExTerm val (Add nextExpr)) = val + eval nextExpr

termParser :: Parser Term
termParser = addParser
  where
    addParser :: Parser Term
    addParser = Add <$ char '+' <*> exprParser

exprParser :: Parser Expr
exprParser = ExTerm <$> double <*> termParser <|> ExEnd <$> double

parseExpr :: Text -> Maybe Expr
parseExpr input = case parseOnly exprParser input of
  Right expr -> Just expr
  Left _ -> Nothing

main :: IO ()
main = do
  let input = "1+2+3"

  -- まずパースしてAST（木）を作る
  case parseExpr input of
    Just ast -> do
      putStrLn $ "パース結果 (AST): " ++ show ast
      -- ASTを eval に渡して計算する！
      putStrLn $ "計算結果: " ++ show (eval ast)
    Nothing ->
      putStrLn "パースに失敗しました"
