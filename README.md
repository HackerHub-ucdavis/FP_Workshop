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

# Different in Style

If we want a function that add 1 to an array and return the result

```python
def add1(xs):
  res = xs
  for i in range(len(res)):
    res[i] = res[i] + 1
  return res
```

<!-- slide -->

## with some functional thinking

### Py with list comprehension

```python
def add1(xs):
  return [i + 1 for i in xs]
```

### Functional JS

```js
function add1(xs) {
  return xs.map(x => x + 1);
}
```

<!-- slide -->

## Still lots of noise in the function definition

* Why do we have to explicitly construct a new list?
* Why do the map function is associated with the list `xs`?
* Why we still need to write a arrow function even we know `map` function applies to each element in `xs`?
* Why so much parentheses?

```haskell
add1 xs = map (+1) xs

-- better
add1 = map (+1)
```

<!-- slide -->

## A Quick Comparison With Quick Sort

<!-- slide -->

### Python Example

From [geeks for geeks](https://www.geeksforgeeks.org/python-program-for-quicksort/).

```python
def partition(arr, low, high):
    i = (low-1)         # index of smaller element
    pivot = arr[high]     # pivot
  
    for j in range(low, high):
  
        # If current element is smaller than or
        # equal to pivot
        if arr[j] <= pivot:
  
            # increment index of smaller element
            i = i+1
            arr[i], arr[j] = arr[j], arr[i]
  
    arr[i+1], arr[high] = arr[high], arr[i+1]
    return (i+1)
  
# The main function that implements QuickSort
# arr[] --> Array to be sorted,
# low  --> Starting index,
# high  --> Ending index
  
# Function to do Quick sort

  
def quickSort(arr, low, high):
    if len(arr) == 1:
        return arr
    if low < high:
  
        # pi is partitioning index, arr[p] is now
        # at right place
        pi = partition(arr, low, high)
  
        # Separately sort elements before
        # partition and after partition
        quickSort(arr, low, pi-1)
        quickSort(arr, pi+1, high)
```

<!-- slide -->

### Easier with List Comprehension

**NOTE**: not exactly the same, but intuitive
```python
def quicksort(xs):
    if len(xs) == 0:
        return []

    pivot = xs[0]
    xs = xs[1:]
    left = [x for x in xs if x <= pivot]
    right = [x for x in xs if x > pivot]

    res = quicksort(left)
    res.append(pivot)
    res += quicksort(right)
    return res

```

<!-- slide -->
### Haskell Example

```haskell
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort (x : xs) = quicksort left ++ [x] ++ quicksort right
  where
    left = [y | y <- xs, y < x]
    right = [y | y <- xs, y >= x]
```

<!-- slide -->

# Use of `ghc`/`ghci`

`ghc`: compiler
`ghci`: The interactive shell of haskell, just like `IDLE` for python

### How to compile

```sh
ghc main.hs
```

### Useful command in `ghci`
* `:t` or `:type` check the type signature of a expression.
* `:l` load a local file (Module)

For more detailed doc, see links at end of slides.

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
suppose `(+) :: Num a => a -> a -> a` , what is `x` ?

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

## Higher-order-functions

functions who takes in a functions as parameter and/or returns a function.
Some well-known examples that exits in may languages
* `map :: (a -> b) -> [a] -> [b]`
* `reduce :: (a -> a -> a) -> [a] -> a`
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
```

<!-- slide -->

# Challenge

Make a interesting and useful function library based on `foldr` .
* you may only use `foldr` and operators in haskell Prelude
* once you make the first two functions with `foldr`, you can start composing them to get new functions
* To Submit, fork this repository, write your name and email on top of `README.md`.
  + write your library in `MyLibrary.hs`
  + create and write a documentation `doc.md` for your library.
  + To test your functions, use the interactive shell `ghci MyLibrary.hs`
  + Submit a pull request to this repo when finished.

<!-- slide -->

# Useful Links
* [GHC User's Guide](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/)
* [Foldl vs Foldr](https://gist.github.com/CMCDragonkai/9f5f75118dda10131764)
* [A Gentle Introduction to Haskell](https://www.haskell.org/tutorial/)
* [Official Doc](https://www.haskell.org/documentation/)
