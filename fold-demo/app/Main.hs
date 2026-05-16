module Main where

import Debug.Trace (trace)

addTrace :: Int -> Int -> Int
addTrace x y = trace ("計算: " ++ show x ++ " + " ++ show y) (x + y)

addIOr :: Int -> IO Int -> IO Int
addIOr x macc = do
  putStrLn $ "これから " ++ show x ++ " を処理開始"
  acc <- macc
  return (x + acc)

addIOl :: IO Int -> Int -> IO Int
addIOl macc x = do
  putStrLn $ "これから " ++ show x ++ " を処理開始"
  acc <- macc
  return (x + acc)

# https://www.notion.so/Haskell-35c3a7d6893e80128fa8cdeab9d3a78b?source=copy_link#3623a7d6893e80a19323de8a1010b837
main :: IO ()
main = do
  putStrLn "------- 正格評価"
  putStrLn "foldr"
  print (foldr addTrace 0 [1, 2, 3, 4, 5])
  putStrLn ""
  putStrLn "foldl"
  print (foldl addTrace 0 [1, 2, 3, 4, 5])

  putStrLn "------- 非正格評価"
  putStrLn "foldr"
  rresult <- foldr addIOr (return 0) [1, 2, 3, 4, 5]
  putStrLn $ show rresult
  putStrLn "foldl"
  lresult <- foldl addIOl (return 0) [1, 2, 3, 4, 5]
  putStrLn $ show lresult
