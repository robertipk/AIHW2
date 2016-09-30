# determines if a 1-D array of 9 elements contains each digit 1-9 once
def no_dups(arr)
 if arr.length != 9
   return false
 end
 counts = Array.new(10,-1)
 for x in 0...arr.length
   if arr[x].to_i<1 || arr[x].to_i>9
     return false
   elsif counts[arr[x].to_i]>-1
     return false
   else
     counts[arr[x].to_i]+=1
   end
 end
 true
end
