{-
For some reason the results loses precision when |X| is significantly larger than Pi.
For said reason we must reduce the ressould to a range between -Pi & Pi.

Input:	Float
	Any number X.

Output:	Float
	Equivalent number X between -Pi & Pi
-}
reduceToPi :: Float -> Float
reduceToPi x
    |   x > pi      = reduceToPi (x - pi)
    |   x < -pi     = reduceToPi (x + pi)
    |   otherwise   = x



{-
Exponentiation of a Float raised to an Integer power.

Input:
	Float	-> Base (B)
	Integer	-> Exponent (E)

Output:	Float
	The product of B multiplied by itself E times.

Notes:
	- E = 0, always returns 1 (X^0 = 1).
	- E = 1, always returns the base itself.
    - To avoid using the built-in exponentiation function (^), we needed to implement recursively:
        B^E = B * B^(E - 1)
-}
exponential :: Float -> Int -> Float
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y - 1)



{-
Factorialization of an Integer.

Input:	Integer X (please no too large)

Output:	Factorial of X

Notes:
    - By definition: 0! is equal to 1
	- In order to use factorial in Haskell without exporting external Libraries we must recursively built the function:
        X! = X * (X - 1)!
-}
factorial :: Int -> Integer
factorial 0 = 1
factorial x = fromIntegral x * factorial (x - 1)



{-
Cosine of X with the Taylor Series.

Input:
	Float	-> Number X to find its Cosine.
	Integer	-> Degree of Precision.
	Integer	-> Current iteration N (Should start with 0)
Output:	Float
	Sum of "(-1)^N * X^2n / (2N)!" from 0 to the Degree of Precision specified.
-}
cosineSum :: Float -> Int -> Int -> Float
cosineSum x y n
    |   n < y =
        (exponential (-1) n * exponential x (2 * n) / fromIntegral (factorial (2 * n)))
        + cosineSum x y (n + 1)
    |   otherwise   = 0



{-
Calls the cosineSum function and starting Iteration at 0.

Input:
	Float	-> Value X to be processed with the Taylor series of Cos(x).
	Integer	-> Degree of Precision.

Output:	Float
	Sum of "(-1)^N * X^2n / (2N)!" from 0 to the Degree of Precision specified.
-}
cosine :: Float -> Int -> Float
cosine x y = cosineSum (reduceToPi x) y 0




--  TESTING

compareFunction :: Float -> Int -> IO()
compareFunction x y = do
    putStrLn (show x ++ "\n\tIntegrated:\t\t\t" ++ show (cos x))
    putStrLn ("\tSumatory (" ++ show y ++ " precision):\t" ++ show (cosine x y) ++ "\n")

testing :: Int -> Float -> IO()
testing value iteration = do
    if iteration <= 100 then do
        compareFunction iteration value
        testing value (iteration + 1)
    else print "End of Test"

main :: IO()
main = do
    testing 15 (-100)