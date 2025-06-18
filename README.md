# se4sci2025_functional_programming
Functional Programming Examples in Haskell &amp; Python

### Running the Haskell code

Compile (using [ghc](https://www.haskell.org/ghc/)):
```shell
ghc functional_programming.hs
```

Run:
```shell
./functional_programming
>> Currying examples:
>> 1 + 2 = 3
>> 10 (+ 3) (+ 3) = 16
>> Hip Hip Hurray!
>>
>> Recursion examples:
>> Increase each value from [2,1,5,3,4] by 1: [3,2,6,4,5]
>> Select only the 3 from [2,1,5,3,4]: [3]
>> Reduce [2,1,5,3,4] through multiplication into: 120
>> Summing [2,1,5,3,4]: 15
>> Fibonacci(12) = 233
>> Sorting [2,1,5,3,4] results in [1,2,3,4,5]
>>
>> Lambda function examples:
>> Summing up all tuples inside [(1,1),(2,2),(3,3),(4,4),(5,5)] yields: [2,4,6,8,10]
>> Flipping `3-1` to `1-3`: -2
```


### Compile slides

```shell
npx @marp-team/marp-cli@latest slides.md
```
