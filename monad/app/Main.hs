module Main where

import Control.Monad.Trans.State
import Maybe.MaybeMonad

printItem :: Maybe Item -> IO ()
printItem Nothing = putStrLn " その商品は見つかりませんでした"
printItem (Just item) = putStrLn $ show item

increment :: State Int ()
increment = do
  n <- get
  put (n + 1)

counter :: State Int String
counter = do
  increment
  increment

  finalCount <- get
  return ("最終的なカウント: " ++ show finalCount)

main :: IO ()
main = do
  -- 5.1.2 Maybeモナド
  let humberger = getItemWithMonad menu "Foods" "Humberger"
  printItem humberger
  let sushi = getItemWithMonad menu "Foods" "Sushi"
  printItem sushi

  putStrLn "======================"

  -- 5.1.3 Stateモナド
  let (result, finalState) = runState counter 0
  putStrLn result
  putStrLn $ show finalState
