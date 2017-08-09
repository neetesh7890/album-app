class Banking
 @@number_of_customer = 0

  def initialize(accno, name, mobile)
    @account_number=accno
    @name=name
    @mobile_number=mobile
    @balance=0.0
  end
 
  def withdraw(bal)
    if bal<@balance
       @balance=@balance-bal
    else
       puts "insufficient funds"
    end
  end

  def transfer(other,otherbal)
    if otherbal <= @balance
      @balance = @balance - otherbal
     
      other.setBalance = other.balance + otherbal
       
    else
     puts "#{other.name} balance is low Unable to transfer "
   end
  end
  def deposit(bal)
    @balance = @balance + bal
  end
  
  def name
   @name
  end
  def mobile_number
    @mobile_number
  end

  def account_number
    @account_number
  end

  def balance
    @balance
  end

  def setBalance=(bal)
    @balance = bal
  end

  def display_balance
    puts "MR. #{@name} your account balance is #{@balance}"
  end

  def display_details
    puts "Customer Name=#{@name} "
    puts "customer phone number=#{@mobile_number}"
    puts "customer balance=#{@balance}"
  end
  


end

def start
 puts "welcome !!\n\n"
 puts "What do you want to do: "
 puts "Press 0=>Quit "
 puts "Press 1=>TO Create New Account "
 puts "Press 2=>For Deposit "
 puts "Press 3=>For Withdraw "
 puts "Press 4=>For Transfer "
 puts "Press 5=>To know the bank customer full details "
 @@i=gets.chomp.to_i
 @@count=0
 @@cust_details=[]
while @@i != 0
  case @@i
  when 1
    puts "Enter Your Name: "
    name = gets.chomp
    puts "Enter your account number: "
    accno = gets.chomp.to_i
    puts "Enter your mobile number: "
    mob = gets.chomp.to_i

    @@cust_details[@@count] = Banking.new(accno,name,mob)
    
    @@count+=1
    puts " Your account opened successfully "

  when 2
    puts "Enter your account number: "
    accno = gets.chomp.to_i
    puts "How much do you want to deposit: "
    bal = gets.chomp.to_i
    @@cust_details.each do |t|
      if accno==t.account_number
        t.deposit(bal)
      else
        puts "Account does not exist first create account "
      end
    end


  when 3
    puts "Enter your account number: "
    accno = gets.chomp.to_i 
    puts "How much do you want to withdraw: "
    amt=gets.chomp.to_i
    @@cust_details.each do |t|
      if accno==t.account_number
        t.withdraw(amt)
      end
    end


  when 4
    puts "Enter your account number: "
    accno = gets.chomp.to_i 
    @@cust_details.each do |customer|
      if accno==customer.account_number
        @customer=customer
      end
    end
    puts "Enter customer account number to whom you want to transfer: "
    t2 = gets.chomp.to_i 
    puts "How much do you want to transfer: "
    bal = gets.chomp.to_i

    @@cust_details.each do |t|
      if t2==t.account_number
        @customer.transfer(t,bal)
      end
    end


  when 5
    @@cust_details.each do |t|
      t.display_details
    end   
  when 0
   exit
  end

    puts "Now What do you want to do: "
    puts "Press 0=>Quit "
    puts "Press 1=>TO Create New Account "
    puts "Press 2=>For Deposit "
    puts "Press 3=>For Withdraw "
    puts "Press 4=>For Transfer "
    puts "Press 5=>To know the bank customer full details "
    @@i=gets.chomp.to_i
end
end

#def create_customer
 #puts "get account_number, name, mobile, initialize a account"
 #customer = {}
 #customer[@@number_of_customer] = Trial.new(123, 'Jay', 89622)
 #@@number_of_customer += 1
#end