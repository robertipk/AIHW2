row = 5
column = 5
region_row = 3*(row/3)
region_col = 3*(column/3)
puts "adding row neighbrs"

for p in 0...9
  unless column == p
   puts row.to_s + " " + p.to_s
  end
end

puts "adding column neighbrs"
# # add neighbors in column
for d in 0...9
  unless row == d
      puts d.to_s + " " + column.to_s
  end
end

puts "adding subregion neighbrs"

# # add neighbors in subregion
for a in region_row...region_row+3
  for b in region_col...region_col+3
    unless a == row && b == column
      puts a.to_s + " " + b.to_s
    end
  end
end
