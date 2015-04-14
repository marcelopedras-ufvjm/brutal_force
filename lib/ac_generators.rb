require_relative 'ac_math'
require_relative 'binary_utils'
require_relative 'utils'
require 'facter'
require 'thread'

class AcGenerators

  PROCESSORS_AMOUNT = Facter.value('processors')['count']
  THREADS_AMOUNT = PROCESSORS_AMOUNT/2


  private

  def self.binary_generate(n,p,enum,buffer)
    (enum).each do |b|
      binary = BinaryUtils.to_binary(n,b)
      if p
        if binary.gsub('0','').length == p
          #@@mutex.synchronize do
          buffer[b]=binary
          #end
        else
          buffer[b]=nil
        end
      else
        #@@mutex.synchronize do
        buffer[b]=binary
        #end
      end
    end
  end

  public

  def self.combination_mask(n,p=nil)
    max_number = BinaryUtils.max_number_for_bits(n)
    result = []
    enum = 0..(max_number -1)
    ### without threads
    (enum).each do |b|
      binary = BinaryUtils.to_binary(n,b)
      if p
        if binary.gsub('0','').length == p
          result.push(binary)
        end
      else
        result.push(binary)
      end
    end
    result
  end

  def self.combination_mask_thread(n,p=nil)
    # mutex = Mutex.new
    max_number = BinaryUtils.max_number_for_bits(n)
    buffer = Array.new(max_number)
    # enum = 0..(max_number -1)

    ### with threads

    ranges = Utils.to_ranges(max_number,THREADS_AMOUNT)

    threads=ranges.map do |r|
      Thread.new do
        binary_generate(n,p,r,buffer)
      end
    end

    threads.each do |t|
       t.join
    end

    if p
      buffer.select do |c|
        !c.nil?
      end
    else
      buffer
    end
  end


  def self.combination(group,p=nil)
    combination_mask(group.count,p).map do |c|
      BinaryUtils.apply_mask(c,group).join
    end
  end

  def self.arrangement(group,p=nil)
    result = []
    combinations=combination_mask(group.count, p)
    combinations.each do |c|
      buffer=BinaryUtils.apply_mask(c,group)
      result=result+ buffer.permutation.to_a.map do |x|
        x.join
      end

    end
    result
  end
end