factorial :: Int -> Int
factorial 0 = 1
factorial x = x * factorial (x - 1)


exponential :: Float -> Int -> Float
exponential _ 0 = 1
exponential x 1 = x
exponential x y = x * exponential x (y - 1)


-- Internal Function that cosine function calls.
cosineSum :: Float -> Int -> Int -> Float
cosineSum x y n
    |   n < y   = (exponential (-1) n * exponential x (2*n) / fromIntegral (factorial (2 * n))) + cosineSum x y (n+1)
    |   otherwise   = 0


-- What user calls with the N degree of precision
cosine :: Float -> Int -> Float
cosine x y = cosineSum x y 0


main :: IO()
main = do
    print (cos 1) -- Full precision .5403023058681398
    print (cosine 1 10) --  10 precision .5403023