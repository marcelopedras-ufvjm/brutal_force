class BinaryUtils
  def to_binary(num_bits, number)
    ("%0#{num_bits}b" % number)
  end

  def min_bits_to_represent(number)
    Math.log2(number).to_i + 1
  end

  def max_number_for_bits(amount_bits)
    2**amount_bits
  end

  def apply_mask(string_mask,array_string)
    buffer = []
    string_mask.each_char.with_index do |b,i|
      if b == '1'
        buffer.push(array_string[i])
      end
    end
    buffer
  end
end