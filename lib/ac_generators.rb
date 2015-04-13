require_relative 'ac_math'
require_relative 'binary_utils'

class AcGenerators
  def self.combination_mask(n,p=nil)
    max_number = BinaryUtils.max_number_for_bits(n)
    result = []
    enum = 0..(max_number -1)

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