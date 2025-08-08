isDecending :: [Float] -> Bool
isDecending [] = False
isDecending [x] = True
isDecending (x:y:xs) 
    |   x < y       = False
    |   otherwise   = isDecending(y:xs)


orderDesRow :: [Float] -> [Float]
orderDesRow [x] = [x]
orderDesRow (x:y:xs)
    |   isDecending (x:y:xs) = x : y : xs --If Array ordered then just return
    |   otherwise = do
        if x < y 
            then y : orderDesRow (x:xs)
            else x : orderDesRow (y:xs)

orderDes :: [Float] -> [Float]
orderDes xs
    |   isDecending xs = xs
    |   otherwise = orderDes(orderDesRow xs)