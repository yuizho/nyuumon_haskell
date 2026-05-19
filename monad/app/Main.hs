module Main where

import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Control.Monad.Trans.Reader (Reader, ask, runReader)
import Control.Monad.Trans.State
import Data.STRef (modifySTRef, newSTRef, readSTRef)
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

type Config = String

getUrl :: Reader Config String
getUrl = do
  profile <- ask
  if profile == "prod"
    then return "https://example.com"
    else return "http://localhost:8080"

myApp :: Reader Config String
myApp = do
  -- getUrlだけでconfigが取れる
  url <- getUrl
  return ("接続先は " ++ url ++ " です")

counterBySTs :: Integer
counterBySTs = runST $ do
  n <- newSTRef 0

  forM_ [0 .. 5] $ \i -> do
    modifySTRef n (+ i)

  readSTRef n

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

  putStrLn "======================"

  -- 5.5 Readerモナド
  let appResult = runReader myApp "prod"
  putStrLn appResult

  putStrLn "======================"

  -- 5.6 Stsモナド
  print counterBySTs
