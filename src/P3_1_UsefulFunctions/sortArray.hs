{-
Checks whatever a given array is on a descending order.

Input: [Float]
	Finite array of Float.

Output:	Boolean
	-> True:	If there is only 0 or 1 elements on the array.
	-> False:	If detected a single pair of elements out of order.

Notes:
	- Array must be finite, otherwise function may not terminate.
	- In order to compute the order of any array we must rely on recursion and just analyze a single pair at a time:
        isdescending [n1, n2, n3, ..., nx] <=> (n1 >= n2) & isdescending [n2, n3, ..., nx]
-}
isdescending :: [Float] -> Bool
isdescending [] = True
isdescending [x] = True
isdescending (x:y:xs) 
    |   x < y       = False
    |   otherwise   = isdescending(y:xs)



{-
Makes a single round of swapping every pair of elements out of order.

Input:	[Float]
	Finite array of Float.

Output:
	Array after a single iteration of swapping out of order elements.

Notes:
	- If array is already ordered then just returns array.
-}
swapElementDes :: [Float] -> [Float]
swapElementDes [x] = [x]
swapElementDes (x:y:xs)
    |   isdescending (x:y:xs) = x:y:xs -- If sorted Array, just returns
    |   x < y       = y : swapElementDes (x:xs) -- Swaps if element is not descending.
    |   otherwise   = x : swapElementDes (y:xs)



{-
Loops checking if array is in a descending order.
If it's not, swaps every out of order pair of elemets and checks again.

Input:	[Float]
	Finite array of Float.

Output:	[Float]
	Array of Float in a descending order.
-}
orderDes :: [Float] -> [Float]
orderDes xs
    |   isdescending xs  = xs
    |   otherwise       = orderDes(swapElementDes xs)





--	TESTING
main :: IO()
main = do
    let array = [1, 25, 5, -4, 88, -1.4, -95, 0.0, 9.8]
    
    print array

    print (orderDes array)
