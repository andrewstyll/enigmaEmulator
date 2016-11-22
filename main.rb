#! /usr/bin/env ruby

require_relative 'enigma'

#initialise all of the rotors and reflectors to be used for the enigma. We're suporting the 5 rotor enigma with the 3
#relfector board (circa 1938)

rotor1 = stringToPerms("EKMFLGDQVZNTOWYHXUSPAIBRCJ")
rotor2 = stringToPerms("AJDKSIRUXBLHWTMCQGZNPYFVOE")
rotor3 = stringToPerms("BDFHJLCPRTXVZNYEIWGAKMUSQO")
rotor4 = stringToPerms("ESOVPZJAYQUIRHXLNFTGKDCMWB")
rotor5 = stringToPerms("VZBRGITYUPSDNHLXAWMJQOFECK")

rotors = [rotor1, rotor2, rotor3, rotor4, rotor5]
rotorNotches = [charToNum("Q"), charToNum("E"), charToNum("V"), charToNum("J"), charToNum("Z")]

reflectorA = stringToPerms("EJMZALYXVBWFCRQUONTSPIKHGD")
reflectorB = stringToPerms("YRUHQSLDPXNGOKMIEBFZCWVJAT")
reflectorC = stringToPerms("FVPJIAOYEDRZXWGCTKUQSBNMHL")

reflectors = [reflectorA, reflectorB, reflectorC]

rotorSelect = Array.new
rotorNotchesSelect = Array.new
reflectorSelect = Array.new
rotorPosSelect = Array.new
ringPosSelect = Array.new

config = ""

#read in parameters from the confguration file :D

ARGF.each_line do |line|
    input = line.chomp.split(" ") 
    if input[0] == "rotor:"
        rotorSelect = [rotors[input[1].to_i-1], rotors[input[2].to_i-1], rotors[input[3].to_i-1]]
        rotorNotchesSelect = [rotorNotches[input[1].to_i-1], rotorNotches[input[2].to_i-1], rotorNotches[input[3].to_i-1]]
        config << "rotors: #{input[1].to_i}, #{input[2].to_i}, #{input[3].to_i}\n"
    elsif input[0] == "reflector:" 
        reflectorSelect = reflectors[charToNum(input[1])]
        config << "reflector: #{input[1]}\n"
    elsif input[0] == "rotorPosition:"
        rotorPosSelect = [input[1].to_i, input[2].to_i, input[3].to_i]
        config << "rotor positions: #{input[1].to_i}, #{input[2].to_i}, #{input[3].to_i}\n"
    elsif input[0] == "ringPosition:"
        ringPosSelect = [input[1].to_i, input[2].to_i, input[3].to_i]
        config << "ring positions: #{input[1].to_i}, #{input[2].to_i}, #{input[3].to_i}\n"
    end
end

print config

#and off to the races we go

while true do
    print "Please enter a message: "
    message = STDIN.gets 
    puts encodeMessage(message, rotorSelect, reflectorSelect, rotorPosSelect, rotorNotchesSelect, ringPosSelect)
end
