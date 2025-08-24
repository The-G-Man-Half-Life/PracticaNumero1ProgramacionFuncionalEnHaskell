------------------------------------------------------------------------------
-- obtainListLength
-- What does it do?: It calculates the length of an array
-- Inputs: 
-- -Any list of doubles
-- Output: 
-- -The length of the array as an int
------------------------------------------------------------------------------
obtainListLength :: [Double] -> Int
obtainListLength [] = 0
obtainListLength (_:xs) = 1 + obtainListLength xs

------------------------------------------------------------------------------
-- gnrtAbs
-- What does it do?: It returns the absolute value of a number
-- Inputs: 
-- -Any number as a double
-- Output: 
-- -A number in its absolute form as a double
------------------------------------------------------------------------------
gnrtAbs :: Double -> Double
gnrtAbs x = if x < 0 then -x else x

------------------------------------------------------------------------------
-- obtainSqrt
-- What does it do?: It calculates the square root of a number
-- using the Newton-Raphson method 
-- Inputs: 
-- -Any number as a double
-- Output: 
-- -The square root of the number as a double
------------------------------------------------------------------------------
obtainSqrt :: Double -> Double
obtainSqrt num
  | num == 0 = 0
  | otherwise = useNewtonMethod num (num / 2)
  where
    epsilonVal = 1.0e-12
    useNewtonMethod target y =
      let y2 = (y + target / y) / 2
      in if gnrtAbs (y2 - y) < epsilonVal then y2
         else useNewtonMethod target y2

------------------------------------------------------------------------------
-- determineFactorA
-- What does it do?: It determines the correct factor A to use 
-- based on the index coefficient and signal length
-- Inputs: 
-- -An int representing the index coefficient
-- -An int representing the signal length
-- Output: 
-- -A double representing the value of factor A
------------------------------------------------------------------------------
determineFactorA :: Int -> Int -> Double
determineFactorA indexCoefficient signalLength
  | indexCoefficient == 0 = obtainSqrt (1 / fromIntegral signalLength)
  | otherwise             = obtainSqrt (2 / fromIntegral signalLength)

------------------------------------------------------------------------------
-- sumOfCosProduct
-- What does it do?: It calculates the sum of cosine products for DCT
-- Inputs: 
-- -The index coefficient as an int
-- -A list of doubles representing the signal
-- -The length of the given list as a double
-- -The recursion index as an int (updated recursively)
-- -The accumulated value of the sum as a double
-- Output:
-- -The total value of the accumulated sum of cosine products
------------------------------------------------------------------------------
sumOfCosProduct :: Int -> [Double] -> Double -> Int -> Double -> Double
sumOfCosProduct _ [] _ _ accumulation = accumulation
sumOfCosProduct indexCoefficient (x:xs) lengthAsDouble recursionIdx accumulation = 
  let indexCoefficientD = fromIntegral indexCoefficient
      recursionIdxD = fromIntegral recursionIdx
      argument = ((recursionIdxD + 0.5) * pi * indexCoefficientD) / lengthAsDouble
      term = x * cos argument
      accumulationD = accumulation + term
  in sumOfCosProduct indexCoefficient xs lengthAsDouble (recursionIdx + 1) accumulationD

------------------------------------------------------------------------------
-- obtainCoefficientK
-- What does it do?: It calculates the coefficient K
-- Inputs:
-- -An int representing the coefficient index k
-- -A list of doubles representing the list
-- Output:
-- -A double corresponding to the coefficient K
------------------------------------------------------------------------------
obtainCoefficientK :: Int -> [Double] -> Double
obtainCoefficientK k xs =
  let lenInt = obtainListLength xs
      lenIntD = fromIntegral lenInt :: Double
      factorAVal = determineFactorA k lenInt
      sumOfCosineProductVal = sumOfCosProduct k xs lenIntD 0 0.0
  in factorAVal * sumOfCosineProductVal

------------------------------------------------------------------------------
-- obtainDCT
-- What does it do?: It recalls to its aux function that takes care of making
-- the DCT and then receives the list with the DCT
-- Inputs:
-- -A list of doubles representing the list
-- Output:
-- -A list of doubles representing the DCT coefficients
------------------------------------------------------------------------------
obtainDCT :: [Double] -> [Double]
obtainDCT [] = []
obtainDCT xs =
  let lenInt = obtainListLength xs
  in dctAux 0 lenInt xs

------------------------------------------------------------------------------
-- dctAux
-- What does it do?: It recursively calculates the DCT coefficients of a list 
-- by computing coefficient K for each index until all are obtained
-- Inputs:
-- -An int representing the current factor K (index)
-- -An int representing the total length of the list
-- -A list of doubles representing the list
-- Output:
-- -A list of doubles containing all the DCT coefficients
------------------------------------------------------------------------------
dctAux :: Int -> Int -> [Double] -> [Double]
dctAux factorK lenInt xs
  | factorK >= lenInt = []
  | otherwise =
      let coefficient = obtainCoefficientK factorK xs
      in coefficient : dctAux (factorK + 1) lenInt xs

--Tests to prove certain scenarios in which the function may be proved
main :: IO ()
main = do
    putStrLn "obtainDCT tests"

    print "Case 1: empty list"
    print (obtainDCT [])                  
    -- expected: []

    print "Case 2: single element"
    print (obtainDCT [5])                 
    -- expected: [5.0]

    print "Case 3: two elements"
    print (obtainDCT [1,2])               
    -- expected: [~2.121, ~-0.707]

    print "Case 4: three elements"
    print (obtainDCT [1,2,3])             
    -- expected: [~2.449, ~-1.0, ~0.0]

    print "Case 5: four elements"
    print (obtainDCT [1,2,3,4])           
    -- expected: [~5.0, ~-2.230, ~0.0, ~-0.158]

    print "Case 6: symmetric signal"
    print (obtainDCT [1,2,3,2,1])         
    -- expected: [~4.025, ~0.0, ~-1.656, ~-1.656, ~0.0, ~0.246]

    print "Case 7: alternating values"
    print (obtainDCT [1,-1,1,-1])         
    -- expected: [~0.0, ~0.765, ~-0.0, 1,848]