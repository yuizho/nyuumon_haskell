module Main where

import Maybe.MaybeMonad

printItem :: Maybe Item -> IO ()
printItem Nothing = putStrLn " その商品は見つかりませんでした"
printItem (Just item) = putStrLn $ show item

main :: IO ()
main = do
  -- 5.1.2 Maybeモナド
  let humberger = getItemWithMonad menu "Foods" "Humberger"
  printItem humberger
  let sushi = getItemWithMonad menu "Foods" "Sushi"
  printItem sushi
