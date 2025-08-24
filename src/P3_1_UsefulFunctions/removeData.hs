------------------------------------------------------------------------------
-- remData
-- What does it do?: It removes all elements from a list of integers that are 
-- not between the the max and min value
-- Inputs:
-- -A list of integers
-- -An int representing the minimum value
-- -An int representing the maximum value
-- Output:
-- -A list of integers containing only the elements that are within minVal and 
-- maxVal
------------------------------------------------------------------------------
remData :: [Int] -> Int -> Int -> [Int]
remData [] _ _ = []
remData (x:xs) minVal maxVal
    | x >= minVal && x <= maxVal = x : remData xs minVal maxVal
    | otherwise = remData xs minVal maxVal 

--Tests to prove certain scenarios in which the function may be proved
main :: IO ()
main = do
    putStrLn "remove data tests"

    print"Case 1: empty list"
    print (remData [] 1 10)            -- expected: []

    print"Case 2: Not a single element in the range"
    print (remData [1,2,3] 5 10)       -- expected: []

    print"Case 3: all the elements in the range"
    print (remData [4,5,6] 4 6)        -- expected: [4,5,6]

    print"Case 4: some elements in the range"
    print (remData [1,5,10,15] 5 10)   -- expected: [5,10]

    print"Case 5: A single element in the range"
    print (remData [100,200,300] 150 250) -- expected: [200]

    print"Case 6: Range with negative values"
    print (remData [-10,-5,0,5,10] (-7) 3) -- expected: [-5,0]

    print"Case 7: The minimal value is bigger than the max one"
    print (remData [-10,-5,0,5,10] 3 (-7)) -- expected: []