-- We need to narrow x between -Pi and Pi
reduceToPi :: Float -> Float
reduceToPi x
    |   x > pi  = reduceToPi (x - 2*pi)
    |   x < -pi = reduceToPi (x + 2*pi)
    |   otherwise = x


exponential :: Float -> Int -> Float
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y - 1)


factorial :: Int -> Integer
factorial 0 = 1
factorial x = fromIntegral x * factorial (x - 1)



-- Internal Function that cosine function calls.
cosineSum :: Float -> Int -> Int -> Float
cosineSum x y n
    |   n < y =
        (exponential (-1) n * exponential x (2*n) / fromIntegral (factorial (2 * n)))
        + cosineSum x y (n+1)
    |   otherwise   = 0


-- What user calls with the N degree of precision
cosine :: Float -> Int -> Float
cosine x y = cosineSum (reduceToPi x) y 0




-- TESTING
compareCosineFunction :: Float -> Int -> IO()
compareCosineFunction x y = do

    putStrLn ("     Full precision: " ++ show(cos x))
    putStrLn ("     Sumatory with " ++ show y ++ " precision: " ++ show(cosine x y) ++ "\n")

main :: IO()
main = do
    compareCosineFunction 1 10
    compareCosineFunction 2 10
    compareCosineFunction 3 10
    compareCosineFunction pi 10