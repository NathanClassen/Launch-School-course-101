require 'yaml'
MESSAGES = YAML.load_file('calc_messages.yml')

def prompt message
  puts "=> #{message}"
end

def valid_number? num
  num.to_f.to_s == num || num.to_i.to_s == num 
end

def operation_to_msg num
  op = case num
       when '1'
         'Adding'
       when '2'
         'Subtractin'
       when '3'
         'Multiplying'
       when '4'
         'Dividing'
       end
end
############ Start of Program ###########
prompt MESSAGES['welcome']

name = ''

loop do
  name = gets.chomp

  if name.empty?
    prompt MESSAGES['valid_name']
  else
    break
  end
end

prompt MESSAGES['greeting'] + "#{name}!"

loop do # main loop
  num1 = nil
  num2 = nil
  loop do
    prompt MESSAGES['first_num']
    num1 = gets.chomp
    if valid_number? num1
      break
    else
      prompt MESSAGES['num_val_fail']
    end
  end
  loop do
    prompt MESSAGES['second_num']
    num2 = gets.chomp
    if valid_number? num2
      break
    else
      prompt MESSAGES['num_val_fail']
    end
  end

  op_dock = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG
  prompt op_dock
  operator = nil

  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include? operator
      break
    else
      prompt MESSAGES['op_val_fail']
    end
  end

  prompt "#{operation_to_msg operator}" + MESSAGES['working']

  result = case operator
           when '1'
             num1.to_i + num2.to_i
           when '2'
             num1.to_i - num2.to_i
           when '3'
             num1.to_i * num2.to_i
           when '4'
             num1.to_f / num2.to_f
           end

  prompt MESSAGES['answer'] + "#{result}"
  prompt MESSAGES['another_calc']
  another_calc = gets.chomp

  break unless another_calc.downcase.start_with? 'y'
end

prompt MESSAGES['bye_bye']
