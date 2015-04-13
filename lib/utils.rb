require 'net/ssh'

class Utils
  def test_password(host,user,password)
    begin
      Net::SSH.start(host, user,
                     :password     => password,
                     :auth_methods => [ 'password' ],
                     :number_of_password_prompts => 0)
      return true
    rescue Exception => e
      return false
    end
  end

  def to_ranges(total, parts)
    intervals = total/parts

    i=0
    j=intervals-1

    buffer=[]
    while(j < total)
      if (j+intervals > total)
        #fim
        j=total -1
      end
      buffer.push(i..j)
      i=j+1
      j=j+intervals
    end
    buffer
  end
end