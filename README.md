---
presentation:
  theme: night.css
  width: 1200
  height: 1200
  center: true
---

<!-- slide -->
# FP Workshop
HackerHub Intro to FP Workshop

Ethan He
yfhe@ucdavis.edu

<!-- slide -->
## Goal
Create functions from functions.
* composition
* higher order functions

<!-- slide -->

# Basic Syntax

We will use [haskell](https://www.haskell.org) for this workshop

## Variables

define a variable in the following way

```haskell
x = 5 -- a number
xs = [1..5] -- a list
ys = [1, 2, 3, 4, 5]
str = "abc" -- a string
ch = 'a' -- a char
isCorrect = True -- a bool
tuple = (ch, x)
```

* all variables are constant, so immutable
* don't declare variable outside function

<!-- slide -->

### Functions

There are two ways to define a function
1. regular function
2. lambda expression

```haskell
-- regular way
sum a b = a + b
-- lambda
sum = \a b -> a + b 
-- the identifier sum and assignment op = is optional
```

We don't usually give a name to lambda functions since they are mostly used when we only need this function once in code (often called a callback function in engineering)

<!-- slide -->

### Types

We don't have to write the type explicitly in haskell,
the compiler (or linter in your editor) will infer the types itself.

```haskell
x = 5 :: Int

sum :: Int -> Int -> Int
sum a b = a + b

sum' :: Num a => a -> a -> a
sum' a b = a + b
```

The type signature is inspired by the math notation

$$ sum : Int \times Int \rightarrow Int $$

The meaning of this type signature is:
the function `sum` takes two integers and maps to integer.

<!-- slide -->

### Currying

$$ 
sum : Int \times Int \rightarrow Int \\
sum : Int \rightarrow Int \rightarrow Int
$$

Think about this:
If a function takes two parameter, but you just pass one in, what will it turn?

Take binary addition `(+)` as a example,
suppose `(+) :: Num a => a -> a -> a`, what is `x`?
```haskell
add1 = (1+)
x = add1 2
```

<!-- slide -->

## Function Composition

is the same idea as in math,
suppose we have two functions

$$
g : A \rightarrow B \\
f : B \rightarrow C \\
h = f \circ g
$$

is same as

```haskell
g :: a -> b
f :: b -> c
h = f . g
```

You should know the type of function `h` by now.

<!-- slide -->

## Hight-order-functions

functions who takes in a functions as parameter and/or returns a function.
Some well-known examples that exits in may languages
* `map :: (a -> b) -> [a] -> [b]`
* `reduce :: (a -> a) -> [a] -> a`
* `all :: (a -> Bool) -> [a] -> Bool`
* `takeWhile :: (a -> Bool) -> [a] -> [a]`
* `zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]`

the composition operator is also a binary higher-order function

```haskell
(.) :: (b -> c) -> (a -> b) -> a -> c
```

<!-- slide -->

## Fold

`fold` is the key function in functional programming,
ideally we can create any function with only `foldr`

```haskell
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b

-- or for simplicity
foldr :: (a -> b -> b) -> b -> [a] -> b
```

![foldr](./img/foldr.png)

To understand this function, we can take list as an example.
In haskell, the list is just a data connected with operator `(:)`
```haskell
(:) :: a -> [a] -> [a]
```
so
```haskell
[] == []
[5] == 5 : []
[4, 5] == 4 : (5 : [])
```

Since `(:)` is bust a binary operator, we can replace it with any other binary operator,
which gives the definition of "Foldable".

<!-- slide -->

### Examples

```haskell
map' :: (a -> b) -> [a] -> [b]
reduce :: (a -> b) -> [a] -> [b]
all' :: (a -> b) -> [a] -> [b]
```

<!-- slide -->

# Challenge

Make a interesting and useful function library based on `foldr`.
* you may only use `foldr` and operators in haskell Prelude
* once you make the first two functions with `foldr`, you can start composing them to get new functions
* To Submit, fork this repository, write your name and email on top of `README.md`. Submit a pull request when finished.

<!-- slide -->

# Useful Links
* [Foldl vs Foldr](https://gist.github.com/CMCDragonkai/9f5f75118dda10131764)
* [A Gentle Introduction to Haskell](https://www.haskell.org/tutorial/)
* [Official Doc](https://www.haskell.org/documentation/)

