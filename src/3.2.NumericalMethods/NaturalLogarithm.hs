exponential :: Double -> Int -> Double
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y-1)


-- Internal function Natural Logarithm function calls
naturalLogSum :: Double -> Int -> Int -> Double
naturalLogSum x y n
    |   n < y       = (exponential (-1) (n+1) * exponential x n / fromIntegral n) + naturalLogSum x y (n+1)
    |   otherwise   = 0


-- Main function user calls with N degree of precision
naturalLog :: Double -> Int -> Double
naturalLog x y = naturalLogSum x y 0


--  TESTING
compareLogarithmFunction :: Double -> Int -> IO()
compareLogarithmFunction x y = do
    putStrLn ("     Full precision: " ++ show(log x))
    putStrLn ("     Sumatory with " ++ show y ++ " precision: " ++ show(naturalLog x y) ++ "\n")


main :: IO ()
main = do
    compareLogarithmFunction 1 10
    compareLogarithmFunction 2 10
    compareLogarithmFunction 10 15