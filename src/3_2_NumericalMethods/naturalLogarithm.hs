--  Returns Absolute Value of a Float
absValue :: Float -> Float
absValue x
    |   x >= 0      = x
    |   otherwise   = -x


-- Returns a Float raised to an Integer power without the use of (^) operator.
exponential :: Float -> Int -> Float
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y-1)


{-
Inputs
    Float   -> Value between -1 & 1 to find the Natural Logarithm
    Integer -> Degree of precision.
    Integer -> Number of Iteration, should be started with 1.

Output Float
    Sum of "(-1)^(n+1) * (x^n / n)" from 1 to the degree of precision specified.
-}
naturalLogSum :: Float -> Int -> Int -> Float
naturalLogSum x y n
    |   n <= y       = (exponential (-1) (n+1) * (exponential x n / fromIntegral n)) + naturalLogSum x y (n+1)
    |   otherwise   = 0


{-
    Float   ->
    Integer ->
    
-}
naturalLog :: Float -> Int -> Float
naturalLog x n
    |   absValue x < 1 = naturalLogSum x n 1
    |   otherwise = 0





--  JUST TESTING
compareFunction :: Float -> Int -> IO()
compareFunction x y = do
    putStrLn (show x ++ "\tFull precision:\t\t\t" ++ show (log (1+x)))
    putStrLn ("\t\tSumatory (" ++ show y ++ " precision):\t" ++ show (naturalLog x y) ++ "\n")

testInRange :: Float -> Float -> Float -> Int -> IO()
testInRange x dy z a = do
    if x <= z then do
        compareFunction x a
        testInRange (x + dy) dy z a
    else print "End of Test"

main :: IO ()
main = do
    testInRange (-1.02) 0.01 1.02 256

--  FINISH TESTING