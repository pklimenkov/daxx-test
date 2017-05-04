#!/usr/bin/env ruby
#:encoding: utf-8

require 'active_model'
require 'ruby-try'
require 'validates_type'
require 'yaml'
require 'pry'

Dir[File.join(File.expand_path(File.dirname(__FILE__)), 'lib', '**', '*.rb')].each do |fp|
  load fp
end

puts 'Starting phone number speller'
@speller = Speller.new
loop do
  puts 'Please enter valid phone number like 1-800-2222222222'
  value = gets.chomp.strip

  phone_number = PhoneNumber.new(value)
  unless phone_number.valid?
    puts '====================================='
    puts '               ERROR'
    puts '====================================='
    phone_number.errors.full_messages.each_with_index do |message, index|
      puts "#{index + 1}. #{message}"
    end
    puts '====================================='
    puts '  NUMBER WAS NOT PROCEED. TRY AGAIN'
    puts '====================================='
    next
  end

  results = @speller.convert(phone_number.number)

  puts '====================================='
  puts '              FINISHED'
  puts '====================================='

  if results.empty?
    puts "#1: +#{phone_number.country}(#{phone_number.area})#{phone_number.number}"
  else
    results.each_with_index do |result, index|
      puts "##{index + 1}: +#{phone_number.country}(#{phone_number.area})#{result}"
    end
  end
  puts '====================================='

  input = nil
  loop do
    puts 'Any additional inputs? (yes/no)'
    input = gets.chomp.strip
    break if %w[yes no].include?(input)
  end
  break if input == 'no'
end

puts 'Tanks for using!'
puts 'done by Pavel Klimenkov as test task for Daxx company'
puts 'Have a nice day!'
