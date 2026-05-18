module Maybe.MaybeMonad where

type Category = String

type Name = String

type Price = Integer

type Menu = [(Category, [(Name, Price)])]

type Item = (Category, Name, Price)

menu :: Menu
menu =
  [ ( "Foods",
      [ ("Humberger", 120),
        ("FrenchFries", 100)
      ]
    ),
    ( "Drinks",
      [ ("Cola", 80),
        ("Tea", 100)
      ]
    )
  ]

getItemWithMonad :: Menu -> Category -> Name -> Maybe Item
getItemWithMonad menu category name = do
  -- lookupで一致するmenuを探してMaybe (Name, Price)を返す
  subMenu <- lookup category menu
  price <- lookup name subMenu

  return (category, name, price)
