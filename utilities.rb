# determines if a 1-D array of 9 elements contains each digit 1-9 once
def no_dups(arr)
 if arr.length != 9
   return false
 end
 counts = Array.new(10,-1)
 for x in 0...arr.length
   if arr[x]<1 || arr[x]>9
     return false
   elsif counts[arr[x]]>-1
     return false
   else
     counts[arr[x]]+=1
   end
 end
 true
end
