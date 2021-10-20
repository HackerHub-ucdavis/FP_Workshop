module Main where

import MyLibrary ( map' )

main :: IO ()
main = print (map' (+ 1) xs)
  where
    xs = [1 .. 10]