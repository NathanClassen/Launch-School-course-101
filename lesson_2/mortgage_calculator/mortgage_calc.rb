require 'yaml'
MESSAGES = YAML.load_file('mort_calc.yml')

require 'pry'

def pr(msg)
  puts "=> #{msg}"
end

def valid_princpl(loan)
  loan_arr = loan.split('').delete_if { |char| char.to_i.to_s != char }.join('')
  loan_arr.to_i.to_s == loan_arr
end

def validify_principal loan
  loan.split('').delete_if { |char| char.to_i.to_s != char }.join('')
end

def check_apr(apr)
  good_apr = apr
  if apr.split('').first == '.'
    good_apr = apr.split('').unshift('0').join('')
  end
  if apr.to_f < 1
    good_apr = (apr.to_f * 100).round(2).to_s
  end
  good_apr
end

def valid_apr(apr)
  apr.to_f.to_s == apr || apr.to_i.to_s == apr
end

def valid_dur(yrs)
  (yrs.to_i.to_s == yrs) && (%w(10 15 20 25 30 40).include? yrs)
end

pr MESSAGES['welcome']
puts MESSAGES['dec'].center(25)

loop do # main loop
  print MESSAGES['entr_loan']
  loan = nil
  loop do
    loan = gets.chomp
    if valid_princpl loan
      loan = validify_principal(loan)
      break
    else
      print MESSAGES['loan_err']
    end
  end

  pr MESSAGES['entr_apr']
  apr = nil
  loop do
    apr = gets.chomp
    apr = check_apr apr
    if valid_apr apr
      break
    else
      pr MESSAGES['apr_err']
    end
  end
  mpr = (apr.to_f / 100 / 12)

  pr MESSAGES['loan_dur']
  duration = nil
  loop do
    duration = gets.chomp
    if valid_dur duration
      break
    else
      pr MESSAGES['dur_err']
    end
  end
  duration_mnths = duration.to_i * 12

  monthly_payment = loan.to_f *
                    (mpr.to_f /
                    (1 - (1 + mpr.to_f)**-duration_mnths.to_f))

  pr MESSAGES['payments'] + "$#{monthly_payment.round}"

  puts

  pr MESSAGES['another']
  answer = gets.chomp

  break unless answer.downcase.start_with? 'y'
end
