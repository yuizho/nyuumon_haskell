module Main where

import Control.Exception

catchZeroDiv :: ArithException -> IO Int
catchZeroDiv DivideByZero = return 0
catchZeroDiv e = throwIO e

main :: IO ()
main = do
  -- 4.5.1
  (readFile "dummy_file_name_not_exists" >>= putStrLn)
    `catch` (\e -> putStrLn $ displayException (e :: SomeException))
    `finally` (putStrLn "finished!!!")

  -- \$!で右辺を正格評価しないと遅延評価で除算がされるのでcatchをすり抜ける。
  -- デフォルトの遅延評価だとサンクが生成されてreturnがIOの箱に入れられた状態でcatchを通り抜けてしまい、print時に0除算エラーになる
  print =<< (return $! 100 `div` 0) `catch` catchZeroDiv
