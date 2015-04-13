require_relative 'ac_math'
require_relative 'binary_utils'
require_relative 'utils'
require 'facter'
require 'thread'

class AcGenerators

  PROCESSORS_AMOUNT = Facter.value('processors')['count']
  THREADS_AMOUNT = PROCESSORS_AMOUNT/2
  @mutex = Mutex.new

  private

  def binary_generate(n,p,enum)
    result=[]
    (enum).each do |b|
      binary = BinaryUtils.new.to_binary(n,b)
      if p
        if binary.gsub('0','').length == p
          #@@mutex.synchronize do
          result.push(binary)
          #end
        end
      else
        #@@mutex.synchronize do
        result.push(binary)
        #end
      end
    end
    result
  end

  public

  def combination_mask(n,p=nil)
    max_number = BinaryUtils.new.max_number_for_bits(n)
    result = []
    enum = 0..(max_number -1)

    ### with threads

    # ranges = Utils.to_ranges(max_number,THREADS_AMOUNT)
    #
    # threads=ranges.map do |r|
    #   Thread.new do
    #     #@@mutex.synchronize do
    #       out = binary_generate(n,p,r)
    #       @@mutex.synchronize do
    #         result = result + out
    #       end
    #     #end
    #   end
    # end
    #
    # threads.each do |t|
    #    t.join
    # end


    ### without threads
    (enum).each do |b|
      binary = BinaryUtils.new.to_binary(n,b)
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

  def combination_mask_thread(n,p=nil)
    max_number = BinaryUtils.new.max_number_for_bits(n)
    result = []
    enum = 0..(max_number -1)

    ### with threads

    ranges = Utils.new.to_ranges(max_number,THREADS_AMOUNT)

    threads=ranges.map do |r|
      Thread.new do
        #@@mutex.synchronize do
          out = binary_generate(n,p,r)
          @mutex.synchronize do
            result = result + out
          end
        #end
      end
    end

    threads.each do |t|
       t.join
    end


    ### without threads
    # (enum).each do |b|
    #   binary = BinaryUtils.to_binary(n,b)
    #   if p
    #     if binary.gsub('0','').length == p
    #       result.push(binary)
    #     end
    #   else
    #     result.push(binary)
    #   end
    # end
    result
  end


  def combination(group,p=nil)
    combination_mask(group.count,p).map do |c|
      BinaryUtils.new.apply_mask(c,group).join
    end

  end

  def arrangement(group,p=nil)
    result = []
    combinations=combination_mask(group.count, p)
    combinations.each do |c|
      buffer=BinaryUtils.new.apply_mask(c,group)
      result=result+ buffer.permutation.to_a.map do |x|
        x.join
      end

    end
    result
  end
end