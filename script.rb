#!/usr/bin/env ruby
require 'json'
require 'pp'

mom_questions = JSON.parse(File.read("json/mom.json"))
outcomes = JSON.load(File.read("json/assessments.json"))
outcomes = outcomes.to_a
mom_questions = mom_questions.to_h
TOFILE = []
PRINT = ""


def matchNames(mom_questions,currant_outcome) 
  mom_questions.map do |key,val|
    val.each do |key,val|
      if key == currant_outcome["short_title"]
        TOFILE << {guid: currant_outcome["guid"],title:currant_outcome["title"], short_title: currant_outcome["short_title"], level: currant_outcome["level"], qid: val , number:currant_outcome["number"]}
      end
    end 
  end
end

outcomes.each do |key,value| 
  matchNames(mom_questions,key)
end 

 
TOFILE.each do |key,value| 
  level = key[:level]
 if level = 1 
    PRINT << "# #{key[:number]} #{key[:title]}\n    #{key[:short_title]} \n ~#{key[:guid]} \n"
 elsif level = 2
    PRINT << "## #{key[:number]} #{key[:title]} \n  #{key[:short_title]} \n ~#{key[:guid]} \n"
 end
end 
File.open("out.txt",'w') {|f| f.write(PRINT )}

