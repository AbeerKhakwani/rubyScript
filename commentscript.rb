#!/usr/bin/env ruby
require 'json'
require 'pp'

# get the open assessments quiz list
dev_math = File.read("/Users/Kelly/Desktop/text_files/dev_math.json")
dev_math_hash = JSON.parse(dev_math)
# puts  "This is dev math: #{dev_math}"
# puts "THIS THE DEV_MATH_HASH:  #{dev_math_hash}"

    # loop through list
    dev_math_hash.each do |outcome|
    # for each assessment grab the short_title
        puts "THIS IS THE OUTCOME SHORT_TITLE: #{outcome["short_title"]}"
        # set short_title to "short_title"
# NOT WORKING - HOW DO I RETURN THE VALUE TO USE?
        # short_title = #{outcome["short_title"]}
        # return short_title
    end

# get the MOM course data as JSON (block/assessment name/question id)
mom_questions = File.read("/Users/Kelly/Downloads/results.json")
mom_questions_hash = JSON.parse(mom_questions)
# puts "This is mom_questions:  #{mom_questions}"
# puts "THIS IS THE MOM_QUESTIONS_HASH: #{mom_questions_hash}"

# def match_names(mom_questions_hash, short_title)
    # loop through each assessment
    mom_questions_hash.each_value do |assessment|
    # grab the assessment name
        puts "THIS IS THE ASSESSMENT HASH: #{assessment}"

    # if the assessment name is the same as the "short_title"

        # return the question ids for that assessment

        # push that assessment name and associated quesiton ids into a results array

# return the array of matching assessment ids and question ids
    end

# end

puts "yo, this is where you are!!!!!! #{assessment}"
