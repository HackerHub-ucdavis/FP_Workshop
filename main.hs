module Main where

import MyLibrary ( map' )

ys :: [Integer]
ys = [1..100]

add1 :: Integer -> Integer
add1 = (+1)

main :: IO ()
main = print (map' (+ 1) xs)
  where
    xs = [1 .. 10]