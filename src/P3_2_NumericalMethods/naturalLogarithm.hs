absValue :: Float -> Float
absValue x
    |   x >= 0      = x
    |   otherwise   = -x


exponential :: Float -> Int -> Float
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y-1)


-- Internal function Natural Logarithm function calls
naturalLogSum :: Float -> Int -> Int -> Float
naturalLogSum x y n
    |   n <= y       = (exponential (-1) (n+1) * (exponential x n / fromIntegral n)) + naturalLogSum x y (n+1)
    |   otherwise   = 0


-- Main function user calls with N degree of precision
naturalLog :: Float -> Int -> Float
naturalLog x n
    |   absValue x < 1 = naturalLogSum x n 1
    |   otherwise = 0





--  JUST TESTING
rounded :: Float -> Float -> Float
rounded x dy =
    let factor = 10.0 **  fromIntegral(round (logBase 10 dy))
    in fromIntegral (round (x * factor)) / factor

compareFunction :: Float -> Int -> IO()
compareFunction x y = do
    putStrLn (show x ++ "\t\tFull precision:\t\t\t" ++ show (log (1+x)))
    putStrLn ("\t\tSumatory (" ++ show y ++ " precision):\t" ++ show (naturalLog x y) ++ "\n")

testInRange :: Float -> Float -> Float -> Int -> IO()
testInRange x dy z a = do
    if x <= z then do
        let rx = rounded x dy
        compareFunction rx a
        testInRange (rx + dy) dy z a
    else print "End of Test"

main :: IO ()
main = do
    testInRange (-1.02) 0.01 1.02 200

--  FINISH TESTING