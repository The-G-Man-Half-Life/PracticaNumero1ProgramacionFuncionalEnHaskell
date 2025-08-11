aproxSqrt :: Float -> Int -> Float
aproxSqrt value _ | value == 0 = 0
aproxSqrt value iterations = aproximate value iterations (value/2)
    where
        aproximate _ 0 aproximation = aproximation
        aproximate value iterations aproximation =
            let newAproximation = 0.5 * (aproximation + (value / aproximation))
            in aproximate value (iterations - 1) newAproximation

normalizationFactor :: Int -> Int -> Int -> Float
normalizationFactor indexK totalAmountOfData iterations =
  let nAsFloat = fromIntegral totalAmountOfData
      base = if indexK == 0 then 1.0 / nAsFloat else 2.0 / nAsFloat
  in aproxSqrt base iterations

cosenTerm :: Float -> Int -> Int -> Int -> Float
cosenTerm sample indexN indexK totalAmountOfData =
  let nF = fromIntegral indexN
      kF = fromIntegral indexK
      totalF = fromIntegral totalAmountOfData
      argument = (nF + 0.5) * pi * kF / totalF
  in sample * cos argument

sumOfTerms :: [Float] -> Int -> Int -> Int -> Float
sumOfTerms [] _ _ _ = 0
sumOfTerms (sample:leftOver) indexN indexK totalAmountOfData =
  cosenTerm sample indexN indexK totalAmountOfData
  + sumOfTerms leftOver (indexN + 1) indexK totalAmountOfData

coeficientDCT :: [Float] -> Int -> Int -> Int -> Float
coeficientDCT listasamples indexK totalAmountOfData iterations =
  let suma = sumOfTerms listasamples 0 indexK totalAmountOfData
      factor = normalizationFactor indexK totalAmountOfData iterations
  in factor * suma

calculateDCTAux :: [Float] -> Int -> Int -> Int -> [Float]
calculateDCTAux _ indexK totalAmountOfData _ | indexK == totalAmountOfData = []
calculateDCTAux listasamples indexK totalAmountOfData iterations =
  coeficientDCT listasamples indexK totalAmountOfData iterations
  : calculateDCTAux listasamples (indexK + 1) totalAmountOfData iterations

miLength :: [a] -> Int
miLength [] = 0
miLength (_:leftOver) = 1 + miLength leftOver

calcularDCT :: [Float] -> Int -> [Float]
calcularDCT listasamples iterationsRaiz =
  let totalAmountOfData = miLength listasamples
  in calculateDCTAux listasamples 0 totalAmountOfData iterationsRaiz