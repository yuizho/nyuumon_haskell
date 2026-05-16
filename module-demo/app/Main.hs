module Main where

import MyApp.SomeModule

-- 以下はhello関数だけimportするケース
-- import MyApp.SomeModule (hello)

main :: IO ()
main = do
  hello "Haskell"
  bye "Others"
