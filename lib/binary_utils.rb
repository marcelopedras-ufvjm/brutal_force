class BinaryUtils
  def self.to_binary(num_bits, number)
    ("%0#{num_bits}b" % number)
  end

  def self.min_bits_to_represent(number)
    Math.log2(number).to_i + 1
  end

  def self.max_number_for_bits(amount_bits)
    2**amount_bits
  end

  def self.apply_mask(string_mask,array_string)
    buffer = []
    string_mask.each_char.with_index do |b,i|
      if b == '1'
        buffer.push(array_string[i])
      end
    end
    buffer
  end

  def self.count_ones(string_mask)
    string_mask.gsub('0','').length
  end

  def self.count_zeros(string_mask)
    string_mask.gsub('1','').length
  end
end