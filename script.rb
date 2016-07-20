#!/usr/bin/env ruby
require 'json'
require 'pp'

mom_questions = JSON.parse(File.read("json/qid.json"))
outcomes = [
  {guid: "9aeeb040", short_name: "Arithmetic With Fractions", level: 'primary',},
  {guid: "8a98e185776b", short_name: "Adding and Subtracting Fractions", level: 'secondary'},
  {guid: "333333", short_name: "math101", level: 'third'},
]
mom_questions = mom_questions.to_h
TOFILE = []

def matchNames(mom_questions,currant_outcome)
  mom_questions.map do |key,val|
    val.each do |key,val|
      if key == currant_outcome[:short_name]
        TOFILE << {guid: currant_outcome[:guid], short_name: currant_outcome[:short_name], level: currant_outcome[:level], qid: val }
      end
    end 
  end
end

outcomes.each do |key,value|
  matchNames(mom_questions,key)
end 

PRINT =""

TOFILE.each do |key,value| 
  PRINT << case key[:level]
           when 'primary'
             "# #{key[:level]} \n"
           when 'secondary'
             "## #{key[:level]} \n"

           when 'third'
             "### #{key[:level]} \n"
         end
end 



File.open("out.txt",'w') {|f| f.write(PRINT )}
