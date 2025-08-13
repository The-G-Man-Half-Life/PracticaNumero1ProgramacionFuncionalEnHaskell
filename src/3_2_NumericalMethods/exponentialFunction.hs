{-inputs:
an integer-}

{-outputs:
the factorial 
of the integer inserted
-}
obtainFactorial :: Int -> Int

{- this variant of the funcion
serves in case the value of x
is 0-}
obtainFactorial 0 = 1

{-this variant serves as a stop
condition for the values over or 
equal to 1-}
obtainFactorial 1 = 1

{-The function receives
an integer and multiplies
it for the values before it 
in a descending order-}
obtainFactorial n = n * obtainFactorial (n-1)

{-inputs:
a float
an integer-}
{-outputs:
the exponential value of
the number inserted as a float-}
obtainExponential :: Float -> Int -> Float

{-no matter the value of the 
exponent if the base is 0 it will
return 0 to evite unnecesary 
operations-}
obtainExponential 0 _ = 0

{-in case the exponent is 0
it will return 1 and also 
serves as the stop function-}
obtainExponential _ 0 = 1

{-this function multiplies the base
with itself and reduces the exponent
by 1 every loop recalling itself and
repeating the proccess-}
obtainExponential base exponent = base * obtainExponential base (exponent - 1)

{-inputs:a float
an integer-}
{-outputs: the value of x, the value in
which is desired to be approximated 
euler to the x, and 0 which is the beginning-}
expAprox :: Float -> Int -> Float

{-this servves as a recall function to 
expAproxAux which is the one that actually
takes care of evaluating the approximate 
value of euler to the x-}
expAprox valueOfX valueOfAprox = expAproxAux valueOfX valueOfAprox 0

{-inputs:a float
two integers-}
{-outputs: the aproximate value of 
euler to the exponent x-}
expAproxAux :: Float -> Int -> Int -> Float

{-The function takes care of making as much
sums as the valueOfAprox indicates giving in
the end an approximate value of euler to the
x as requested implementing the obtainExponential
and the obtainFactorial functions in it-}
expAproxAux valueOfX valueOfAprox valueOfBegining
    | valueOfBegining == valueOfAprox    = 0
    | otherwise = obtainExponential valueOfX valueOfBegining / fromIntegral (obtainFactorial valueOfBegining) + expAproxAux valueOfX valueOfAprox (valueOfBegining + 1)