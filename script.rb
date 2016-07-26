#!/usr/bin/env ruby
require 'json'
require 'pp'

unless ARGV[0] && ARGV[1]
  puts "Please add the Json file with mom assessment title and questionids followed by the outcomes json"
  exit
end

mom_questions = JSON.parse(File.read(ARGV[0]))
outcomes = JSON.load(File.read(ARGV[1]))
outcomes = outcomes.to_a
mom_questions = mom_questions.to_h
TOFILE = []
NOQS = []


def matchNames(mom_questions,current_outcome)
  mom_questions.map do |key,val|
    val.each do |key,val|
      if key == current_outcome["short_title"]
        TOFILE << {guid: current_outcome["guid"],title:current_outcome["title"], short_title: current_outcome["short_title"], level: current_outcome["level"], qid: val , number:current_outcome["number"]}
      else
        TOFILE << {guid: current_outcome["guid"],title:current_outcome["title"], short_title: current_outcome["short_title"], level: current_outcome["level"], number:current_outcome["number"]}

        unless NOQS.include? current_outcome["short_title"]
          NOQS << current_outcome["short_title"]
        end
      end
    end
  end
end

outcomes.each do |key,value|
  matchNames(mom_questions,key)
end

def returnString(questionId_array)
  string= ""
  if questionId_array
  questionId_array.each do |key,value|
    string += "\n #{key} \n"
  end
end
  return string
end

print = ""
TOFILE.each do |key,value|
  qids= returnString(key[:qid])
  print << case key[:level]
  when '1'
    "\n # #{key[:number]} #{key[:title]}\n#{key[:short_title]}\n ~ #{key[:guid]} \n #{qids} \n"
  when '2'
    "\n ## #{key[:number]} #{key[:title]}\n#{key[:short_title]}\n ~ #{key[:guid]} \n #{qids} \n"
  when '3'
    "\n ### #{key[:number]} #{key[:title]}\n#{key[:short_title]}\n ~ #{key[:guid]} \n #{qids} \n"
  end
end
File.open("output.txt",'w') {|f| f.write(print)}
puts "The output file path: " + Dir.getwd + "/output.txt"

File.open("withoutquestions.txt",'w') {|f| f.write(NOQS)}

puts "The Assessments without questionIds are listed in this file :  " + Dir.getwd + "/withoutquestions.txt"
