#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH << File.join(__dir__, "../lib")
require "rurema_battle"

if ARGV.size == 2
  class_name, version = ARGV
  RuremaBattle.run(class_name: class_name, version: version)
elsif ARGV.size == 1
  class_name = ARGV.first
  RuremaBattle.run(class_name: class_name)
else
  puts "Usage: #{$PROGRAM_NAME} <class_name> [version]"
  exit 1
end

