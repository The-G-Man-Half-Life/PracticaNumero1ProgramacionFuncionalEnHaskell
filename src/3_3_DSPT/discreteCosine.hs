
obtainListLength :: [Double] -> Int
obtainListLength [] = 0
obtainListLength (_:xs) = 1 + obtainListLength xs


myAbs :: Double -> Double
myAbs x = if x < 0 then -x else x


obtainSqrt :: Double -> Double
obtainSqrt num
  | num == 0 = 0
  | num < 0  = error "obtainSqrt: entrada negativa"
  | otherwise = useNewtonMethod num (num / 2)
  where
    epsilonVal = 1.0e-12
    useNewtonMethod target y =
      let y2 = (y + target / y) / 2
      in if myAbs (y2 - y) < epsilonVal then y2
         else useNewtonMethod target y2


accessToAnElementInAList :: [Double] -> Int -> Double
accessToAnElementInAList [] _ = error "accessToAnElementInAList: índice fuera de rango"
accessToAnElementInAList (x:_) 0 = x
accessToAnElementInAList (_:xs) i
  | i < 0     = error "accessToAnElementInAList: índice negativo"
  | otherwise = accessToAnElementInAList xs (i-1)


factorA :: Int -> Int -> Double
factorA indexCoefficient signalLength
  | indexCoefficient == 0 = obtainSqrt (1 / fromIntegral signalLength)
  | otherwise             = obtainSqrt (2 / fromIntegral signalLength)


sumOfCosProduct :: Int -> [Double] -> Double -> Int -> Double -> Double
sumOfCosProduct _ [] _ _ accumulation = accumulation
sumOfCosProduct indexCoefficient (x:xs) lengthAsDouble recursionIdx accumulation = 
  let indexCoefficientD = fromIntegral indexCoefficient
      recursionIdxD = fromIntegral recursionIdx
      argument = ((recursionIdxD + 0.5) * pi * indexCoefficientD) / lengthAsDouble
      term = x * cos argument
      accumulationD = accumulation + term
  in sumOfCosProduct indexCoefficient xs lengthAsDouble (recursionIdx + 1) accumulationD


obtainCoefficientK :: Int -> [Double] -> Double
obtainCoefficientK k xs =
  let lenInt = obtainListLength xs
      lenIntD = fromIntegral lenInt :: Double
      factorAVal = factorA k lenInt
      sumOfCosineProductVal = sumOfCosProduct k xs lenIntD 0 0.0
  in factorAVal * sumOfCosineProductVal


obtainDCT :: [Double] -> [Double]
obtainDCT [] = []
obtainDCT xs =
  let lenInt = obtainListLength xs
  in dctAux 0 lenInt xs


dctAux :: Int -> Int -> [Double] -> [Double]
dctAux factorK lenInt xs
  | factorK >= lenInt = []
  | otherwise =
      let coefficient = obtainCoefficientK factorK xs
      in coefficient : dctAux (factorK + 1) lenInt xs

