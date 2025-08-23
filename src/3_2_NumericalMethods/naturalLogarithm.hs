{-
Input:	Float
	Value to be returned as positive.

Output:	Float
	Absolute value of input.
-}
absValue :: Float -> Float
absValue x
    |   x >= 0    = x
    |   otherwise   = -x



{-
Exponentiation of a Float raised to an Integer power.

Input:
	Float	-> Base (B)
	Integer	-> Exponent (E)

Output:	Float
	The product of B multiplied by itself E times.

Notes
	- E = 0, always returns 1 (x^0 = 1).
	- E = 1, always returns the base itself.
    - To avoid using the built-in exponentiation function (^), we needed to implement recursively:
        B^E = B * B^(E - 1)
-}
exponential :: Float -> Int -> Float
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y-1)



{-
Computes the Natural Logarithm of (1 + x) with the Taylor series.

Input:
	Float	-> Value X between -1 & 1 to find the Natural Logarithm with the Taylor series.
	Integer	-> Degree of Precision.
	Integer	-> Current iteration N (Should start with 1).

Output:	Float
	Sum of "(-1)^(N+1) * (X^N / N)" from 1 to the Degree of Precision specified.
-}
naturalLogSum :: Float -> Int -> Int -> Float
naturalLogSum x y n
    |   n <= y      = ((exponential (-1) (n+1) * exponential x n) / fromIntegral n) + naturalLogSum x y (n+1)
    |   otherwise   = 0



{-
Calls the naturalLogSum starting iteration with 1.

Input:
	Float	-> Value X to be processed with the Taylor series of ln(x+1).
	Integer	-> Degree of Precision.

Output:	Float
	Sum of "(-1)^(N+1) * (X^N / N)" from 1 to the Degree of Precision specified.
-}
naturalLog :: Float -> Int -> Float
naturalLog x n
    |   absValue x < 1 = naturalLogSum x n 1
    |   otherwise = 0





--  JUST TESTING TEMPORARY
compareFunction :: Float -> Int -> IO()
compareFunction x y = do
    putStrLn (show (x / 10) ++ "\n\tIntegrated:\t\t\t" ++ show (log (1+(x / 10))))
    putStrLn ("\tSumatory (" ++ show y ++ " precision):\t" ++ show (naturalLog (x / 10) y) ++ "\n")

testing :: Int -> Float -> IO()
testing a x = do
    if x <= 10 then do
        compareFunction x a
        testing a (x + 1)
    else print "End of Test"

main :: IO ()
main = do
    testing 1024 (-11)
--  FINISH TESTING