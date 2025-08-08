-- Checks if the Array it's in a decending order.
isDecending :: [Float] -> Bool
isDecending [] = False
isDecending [x] = True
isDecending (x:y:xs) 
    |   x < y       = False
    |   otherwise   = isDecending(y:xs)


-- Switches elements a single time.
swapElementDes :: [Float] -> [Float]
swapElementDes [x] = [x]
swapElementDes (x:y:xs)
    |   isDecending (x:y:xs) = x:y:xs -- If sorted Array, just returns
    |   x < y       = y : swapElementDes (x:xs)
    |   otherwise   = x : swapElementDes (y:xs)


-- Checks if the array is sorted, if it's not swaps elements once and checks again.
orderDes :: [Float] -> [Float]
orderDes xs
    |   isDecending xs  = xs
    |   otherwise       = orderDes(swapElementDes xs)

--  TESTING --
main :: IO()
main = do
    let array = [1, 25, 5, -4, 88, -1.4, -95, 0.0, 9.8]
    
    print array

    print (orderDes array)