module MyLibrary where
import Data.List.Split (chunksOf)

quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x : xs) = quicksort left ++ [x] ++ quicksort right
  where
    left = [y | y <- xs, y < x]
    right = [y | y <- xs, y >= x]

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

getTriangles :: [a] -> [[[a]]]
getTriangles = chunksOf 3 . map (take 3) . chunksOf 9
