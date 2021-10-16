module MyLibrary where

map' :: (a -> b) -> [a] -> [b]
map' f = foldr f' []
  where
    f' x acc = f x : acc

reduce :: (a -> a -> a) -> [a] -> a
reduce _ [] = error "TypeError: reduce of empty sequence with no initial value" -- error msg from py
reduce f (x : xs) = foldr f x xs

-- here advanced linter would suggest usr and to replace foldr (&&) True
-- for this project, ignore
-- for future usage of haskell, you should use and
all' :: (a -> Bool) -> [a] -> Bool
all' f xs = foldr (&&) True ys
  where
    ys = map f xs
