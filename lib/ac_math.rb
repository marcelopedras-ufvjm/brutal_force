class AcMath
  def factorial(n)
    if n == 0
      return 1
    end
    (1..n).reduce do |x,y|
      x*y
    end
  end

  def arrangement(n,p=nil)
    if p
      factorial(n)/factorial(n-p)
    else
      result = 0
      (0..n).each do |x|
        result += arrangement(n,x)
      end
      result
    end
  end

  def combination(n,p=nil)
    if p
      factorial(n)/(factorial(p)*(factorial(n-p)))
    else
      result = 0
      (0..n).each do |x|
        result += combination(n,x)
      end
      result
    end
  end
end