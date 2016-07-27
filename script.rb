#!/usr/bin/env ruby
require 'json'
require 'pp'

# takes two command line arguments. if no arguments, displays following message.
unless ARGV[0] && ARGV[1]
  puts "Please add the Json file with mom assessment title and questionids followed by the outcomes json.  e.g., `ruby script.rb json/mom.json json/assessments.json`"
  exit
end

# sets first file to mom_questions and converts to a hash
mom_questions = JSON.parse(File.read(ARGV[0]))

MOM_Q  = {}
mom_questions.each do|block,assessments|
  assessments.each do |key,val|
    MOM_Q[key] = val
  end
end 

# sets second file to outcomes and converts to an array
outcomes = JSON.parse(File.read(ARGV[1]))
# outcomes = outcomes.to_a

# creates empty array to hold output
TOFILE = []

# creates empty array to hold assessments that don't have question sets
NOQS = []

# Takes a parameter of currant outcome
def matchNames(current_outcome)
  if MOM_Q.key?(current_outcome["short_title"])
    current_outcome_short_title = current_outcome["short_title"]
    TOFILE << {guid: current_outcome["guid"],title:current_outcome["title"], short_title: current_outcome["short_title"], level: current_outcome["level"], qid:MOM_Q["#{current_outcome_short_title}"] , number:current_outcome["number"]}
  else  
    if check_in_array(current_outcome["short_title"])
      TOFILE << {guid: current_outcome["guid"],title:current_outcome["title"], short_title: current_outcome["short_title"], level: current_outcome["level"], number:current_outcome["number"]}
    end
  end 
end

def check_in_array(short_title)
  TOFILE.each do |key, val|
    if  short_title == key[:short_title]
      return false 
    else
      NOQS << short_title
      return true 
    end
  end
end 

# for each outcome, takes the key (short name) and iterates through all mom assessments to match by short title
outcomes.each do |key,value|
  matchNames(key)
end

# turns the question id array into a string and puts line break between each value
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

# for each item in the TOFILE array, returns line break separated assessment number, title, short title, guid, and question id
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

# writes the output file to /output.txt
File.open("output.txt",'w') {|f| f.write(print)}
# prints following command line message
puts "The output file path: " + Dir.getwd + "/output.txt"

# writes the content of the NOQS file to /withoutquestions.txt
File.open("withoutquestions.txt",'w') {|f| f.write(NOQS)}
# prints following command line message
puts "The Assessments without questionIds are listed in this file :  " + Dir.getwd + "/withoutquestions.txt"