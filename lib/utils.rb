require 'net/ssh'

class Utils
  def self.test_password(host,user,password)
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
end