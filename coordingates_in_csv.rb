require 'csv'
x = (0..6).to_a
y = Array.new(x.length,19)
c = x.zip(y)
a = CSV.open('block_coordinates.csv','w')
c.each do |line|
  a << line
end
a.close