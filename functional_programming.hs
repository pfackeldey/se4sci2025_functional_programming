-- Functional Programming
--
-- Let's see some Haskell examples!

main = do
  -- Currying:
  -- Every function in Haskell takes 1 parameter, the remaining ones are "curried"
  -- Currying means: transforming 1 function that takes N arguments into N functions that each take 1 argument
  --
  -- In Haskell the syntax is operator-first, i.e. `function arg1 arg2`
  -- In fact this syntax automatically curries already!
  --   function arg1 arg2 = (function arg1) arg2 = curried_function_with_arg1 arg2
  --
  -- Let's see a first simple example of adding 1:
  -- `+` is the addition function
  -- `(+ 1)` "curries" the addition function to always add 1
  let addOne = (+ 1)
  putStrLn $ "1 + 2 = " ++ show (addOne 2)

  -- This `applyFnTwice` function applies `f` two times to `x`
  putStrLn "Currying examples:"
  let applyFnTwice f x = f (f x)

  -- Now let's curry it
  let addThreeTwice = applyFnTwice (+ 3)
  putStrLn $ "10 (+ 3) (+ 3) = " ++ show (addThreeTwice 10)

  -- We can pass any function to `applyFnTwice` to curry it, e.g. prepending a string
  let hipHip = applyFnTwice ("Hip " ++)
  putStrLn $ hipHip "Hurray!"

  putStrLn ""

  -- Recursion:
  putStrLn "Recursion examples:"
  let values = [2, 1, 5, 3, 4]

  -- summation over a list with recursion
  let sum' :: (Num a) => [a] -> a
      sum' [] = 0 -- summing an empty list yields 0
      sum' (x : xs) = x + sum' xs -- summing up all elements until nothing is left in xs
  putStrLn $ "Summing " ++ show values ++ ": " ++ show (sum' values)

  -- Fibonacci sequence
  let fib :: Int -> Int
      fib 0 = 1
      fib 1 = 1
      fib n = fib (n - 1) + fib (n - 2)
  putStrLn $ "Fibonacci(12) = " ++ show (fib 12)

  -- A map implementation with recursion:
  let map' :: (a -> b) -> [a] -> [b]
      map' _ [] = [] -- mapping anything over an empty list returns an empty list
      map' f (x : xs) = f x : map' f xs -- (x: xs) 'pulls out' the first element of `xs`

  -- Curry the map' with our already-curried `addOne` function (double currying!):
  let addOneToEach = map' addOne -- the same as `map' (+ 1)`
  putStrLn $ "Increase each value from " ++ show values ++ " by 1: " ++ show (addOneToEach values)

  -- A filter implementation with recursion:
  let filter' :: (a -> Bool) -> [a] -> [a]
      filter' _ [] = [] -- empty lists can't be further filtered
      filter' p (x : xs) -- (x: xs) 'pulls out' the first element of `xs`
        | p x = x : filter' p xs -- if `p x` is true keep, else recurse through the remaining `xs`
        | otherwise = filter' p xs -- recurse through the remaining `xs`, Haskell requires `otherwise` to be always set

  -- Curry the filter to select 3s
  let selectEqThree = filter' (== 3)
  let values = [2, 1, 5, 3, 4]
  putStrLn $ "Select only the 3 from " ++ show values ++ ": " ++ show (selectEqThree values)

  -- A recursively defined sorting with currying
  -- recursively defined sorting
  let quicksort :: (Ord a) => [a] -> [a]
      quicksort [] = [] -- empty lists can't be sorted
      quicksort (x : xs) =
        -- Algorithm:
        -- 1. (x: xs) 'pulls out' the first element of `xs`
        -- 2. Then we check which values are smaller than `x` in the remaining `xs`
        -- 3. Recurse again through quicksort, this time with the filtered list: filter (<= x) xs
        -- Do the same for all values that are larger...
        -- Now we just need to concat all smaller values with the original x and all larger values
        let smallerSorted = quicksort (filter (<= x) xs)
            biggerSorted = quicksort (filter (> x) xs)
         in smallerSorted ++ [x] ++ biggerSorted
  -- Run sorting
  let sortedValues = quicksort values
  putStrLn $ "Sorting " ++ show values ++ " results in " ++ show sortedValues

  putStrLn ""

  -- Lambdas:
  putStrLn "Lambda function examples:"

  -- Sometimes it's nice to create functions on-the-fly (maybe they're just needed once)
  -- Lambda functions have the structure: `\(arg1, arg2, ...) -> <function body>`
  --
  -- Let's implement a function that sums up all tuples inside a list with a lambda function:
  -- `\(a, b)` is a tuple unpacked into `a` and `b`
  -- The function body `(+ a) b)` sums `a` & `b`
  let sumAllTuples = map' (\(a, b) -> (+ a) b)
  let listOfTuples = [(1, 1), (2, 2), (3, 3), (4, 4), (5, 5)]
  putStrLn $ "Summing up all tuples inside " ++ show listOfTuples ++ " yields: " ++ show (sumAllTuples listOfTuples)

  -- A "flip" function can also be nicely expressed with a lambda:
  let flip' :: (a -> b -> c) -> b -> a -> c
      -- `\x y` is a lambda function that takes 2 args (`x` & `y`) and then
      -- applies `f` in flipped order: first to `y`, then the curried `f(y)` to `x`
      flip' f = \x y -> f y x

  let flipped_substraction = flip' (-)
  putStrLn $ "Flipping `3-1` to `1-3`: " ++ show (flipped_substraction 3 1)
