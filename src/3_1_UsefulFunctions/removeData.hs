{-inputs: 
an integers list
an integer defining minimum value
an integer defining maximum value -}

{-outputs:
an integer list with the values between
the max and min value-}
remData :: [Int] -> Int -> Int -> [Int]

{-if the list is empty it will return an
empty list no matter the min and max value -}
remData [] _ _ = []

{-this part of the function takes the first
element of the list, the min and the max value
if the value taken is between the range of min
and max value then is added to the returninng
list otherwise just recalls the function and 
repeats the proccess -}
remData (x:xs) minVal maxVal
    | x >= minVal && x <= maxVal = x : remData xs minVal maxVal
    | otherwise = remData xs minVal maxVal 