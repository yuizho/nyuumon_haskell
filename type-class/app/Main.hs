module Main where

import Data.List (intercalate)

data Dog = Dog deriving (Show)

data Cat = Cat deriving (Show)

data Human = Human String deriving (Show)

class Greeting a where
  name :: a -> String
  hello :: a -> String
  hello _ = "..."
  bye :: a -> String
  bye _ = "..."

instance Greeting Dog where
  name _ = "a dog"
  hello _ = "Bark!"

instance Greeting Cat where
  name _ = "a cat"
  hello _ = "Meow."

instance Greeting Human where
  name (Human n) = n
  hello h = "Hi, I'm " ++ name h ++ "."
  bye _ = "See you."

sayHello :: (Greeting a) => a -> IO ()
sayHello x = putStrLn (hello x)

class (Greeting a) => Laughing a where
  laugh :: a -> String

-- 3.9.2 型制約
instance Laughing Human where
  laugh _ = "hahaha!"

-- 3.9.3 instance宣言における型宣言
liftGreet :: (a -> String) -> ([a] -> String)
liftGreet f = intercalate "\n" . map f

instance (Greeting a) => Greeting [a] where
  name = liftGreet name
  hello = liftGreet hello
  bye = liftGreet bye

main :: IO ()
main = do
  sayHello (Human "yui")
  putStrLn $ laugh (Human "ito")
  sayHello Dog
  sayHello Cat

  sayHello [Human "yui", Human "ito"]
