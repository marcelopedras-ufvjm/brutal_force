require_relative './lib/ac_generators'
require_relative './lib/utils'

allow_caracters = %w"a b c d e f g h i j k l m n o p q r s t u v w x y z"
allow_numbers = %w"0 1 2 3 4 5 6 7 8 9"
allow_symbols = %w"- _ #"

dictionary = %w"lab ict 2 sala 255 bct # - _ s"
min_lenght = 5
max_lenght = 10

group = %w"a b c d e f g h i j k l m n o p"

start=Time.now
AcGenerators.combination(group)
finish=Time.now
diff = finish - start
puts diff



#
# f=File.open('test.txt','w')
# (5..15).each do |test|
#   p=test
#   n=20
#
#
#   start=Time.now
#   AcGenerators.combination_mask_thread(n,p)
#   finish=Time.now
#   diff = finish - start
#   puts "Instance #{p}"
#   puts 'With thread'
#   puts diff
#   f.puts "Instance #{p}"
#   f.puts 'With thread'
#   f.puts diff
#
#
#   start=Time.now
#   AcGenerators.combination_mask(n,p)
#   finish=Time.now
#   diff = finish - start
#
#   puts 'Without thread'
#   puts diff
#   f.puts 'Without thread'
#   f.puts diff
#   f.puts '---------------------'
#
# end
