require_relative './lib/ac_generators'
require_relative './lib/utils'
require 'thread'

allow_caracters = %w"a b c d e f g h i j k l m n o p q r s t u v w x y z"
allow_numbers = %w"0 1 2 3 4 5 6 7 8 9"
allow_symbols = %w"- _ #"

#dictionary = %w"lab ict 2 sala 255 bct # - _ s ufvjm @ 02"
#dictionary = %w"lab ict sala 255 bct # s ufvjm @"
dictionary = %w"a ict d b # c ufvjm"
min_lenght = 5
max_lenght = 10

group = %w"a b c d e f g h i j k l m n o p"

# start=Time.now
# AcGenerators.combination(group)
# finish=Time.now
# diff = finish - start
# puts diff

puts AcMath.arrangement(dictionary.count)

num_threads = 10
#password_lenght=3

start=Time.now
result=AcGenerators.arrangement(dictionary)
finish=Time.now
diff = finish - start

puts diff

ranges=Utils.to_ranges(result.count, num_threads)
ip_pull = %w"192.168.12.147 192.168.12.158 192.168.12.183 192.168.12.213"
mutex = Mutex.new
log=File.open('log.txt','w+')


def try_broken(combinactions,range,host,user)
  range.each do |c|
    if Utils.test_password(host,user,combinactions[c])
      File.open('senha_recuperada.txt','w+') do |f|
        f.puts(combinactions[c])
        Thread.abort('Senha recuperada')
      end
    end
  end
end

threads=ranges.map do |r|
  Thread.new do
    log=File.open("log_thread#{c}.txt")
    try_broken(result,r,ip_pull[rand(ip_pull.count)],'ufvjm')
  end
end

threads.each do |t|
  t.join
end




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
