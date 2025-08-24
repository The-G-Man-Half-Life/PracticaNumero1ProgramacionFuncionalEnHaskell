------------------------------------------------------------------------------
-- obtainFactorial
-- What does it do?: It calculates the factorial of a number
-- Inputs:
-- -An int representing the number which will be used to calculate the factorial
-- Output:
-- -An int representing the factorial of the number inputted
------------------------------------------------------------------------------
obtainFactorial :: Int -> Int
obtainFactorial 0 = 1
obtainFactorial 1 = 1
obtainFactorial n = n * obtainFactorial (n-1)

------------------------------------------------------------------------------
-- obtainExponential
-- What does it do?: It calculates a number as much times as its exponent says
-- Inputs:
-- -A float representing the base
-- -An int representing the exponent
-- Output:
-- -A float representing the result of base raised to the exponent
------------------------------------------------------------------------------
obtainExponential :: Float -> Int -> Float
obtainExponential 0 _ = 0
obtainExponential _ 0 = 1
obtainExponential base exponent = base * obtainExponential base (exponent - 1)

------------------------------------------------------------------------------
-- expAprox
-- What does it do?: It recalls the auxiliar function that takes care of 
-- making the calculations and thens return the value
-- Inputs:
-- -A float representing the number
-- -An int representing the number of terms to use in the approximation
-- Output:
-- -A float that represents the approximate value of e^x
------------------------------------------------------------------------------
expAprox :: Float -> Int -> Float
expAprox valueOfX valueOfAprox = expAproxAux valueOfX valueOfAprox 0

------------------------------------------------------------------------------
-- expAproxAux
-- What does it do?: It calculates an approximate value of e^x
-- Inputs:
-- -A float representing the number of the exponent
-- -An int representing the total number of terms for the approximation
-- -An int representing the current term index
-- Output:
-- -A float representing the partial sum of the exponential approximation
------------------------------------------------------------------------------
expAproxAux :: Float -> Int -> Int -> Float
expAproxAux valueOfX valueOfAprox valueOfBegining
    | valueOfBegining == valueOfAprox    = 0
    | otherwise = obtainExponential valueOfX valueOfBegining / 
                  fromIntegral (obtainFactorial valueOfBegining) + 
                  expAproxAux valueOfX valueOfAprox (valueOfBegining + 1)

--Tests to prove certain scenarios in which the function may be proved
main :: IO ()
main = do
    putStrLn "Exponential function tests"

    print "Case 1: approximation with 0 terms"
    print (expAprox 1 0)   -- expected: 0 

    print "Case 2: approximation of e^0 with 1 term"
    print (expAprox 0 1)   -- expected: 1

    print "Case 3: approximation of e^1 with 1 term"
    print (expAprox 1 1)   -- expected: 1

    print "Case 4: approximation of e^1 with 2 terms"
    print (expAprox 1 2)   -- expected: 1 + 1 = 2

    print "Case 5: approximation of e^1 with 5 terms"
    print (expAprox 1 5)   -- expected: ~2.7083

    print "Case 6: approximation of e^2 with 5 terms"
    print (expAprox 2 5)   -- expected: ~7.0 

    print "Case 7: larger approximation of e^1 with 10 terms"
    print (expAprox 1 10)  -- expected: ~2.71828 

    print "Case 8: approximation but with negative exponents"
    print (expAprox (-2) 10)  -- expected: ~2.71828 
