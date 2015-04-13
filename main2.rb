require_relative './lib/ac_generators'
require_relative './lib/utils'

allow_caracters = %w"a b c d e f g h i j k l m n o p q r s t u v w x y z"
allow_numbers = %w"0 1 2 3 4 5 6 7 8 9"
allow_symbols = %w"- _ #"

dictionary = %w"lab ict 2 sala 255 bct # - _ s"
min_lenght = 5
max_lenght = 10

# sum = 0
# (4..dictionary.count).each do |x|
#   sum+=AcMath.arrangement(dictionary.count,x)
#end

#puts sum

#puts AcMath.arrangement(dictionary.count)
# f=File.open('result.txt','w')
# f.puts AcGenerators.arrangement(dictionary)
# f.close

f=File.open('test.txt','w')
(1..10).each do |test|
  n=test

  start=Time.now
  AcGenerators.new.combination_mask_thread(n)
  finish=Time.now
  diff = finish - start
  puts "Instance #{n}"
  puts 'With thread'
  puts diff
  f.puts "Instance #{n}"
  f.puts 'With thread'
  f.puts diff


  start=Time.now
  AcGenerators.new.combination_mask(n)
  finish=Time.now
  diff = finish - start

  puts 'Without thread'
  puts diff
  f.puts 'Without thread'
  f.puts diff
  f.puts '---------------------'

end
