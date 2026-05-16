module MyApp.SomeModule (hello, bye) where

hello :: String -> IO ()
hello name = putStrLn (name ++ ", hello!")

bye :: String -> IO ()
bye name = putStrLn (name ++ ", bye!")
