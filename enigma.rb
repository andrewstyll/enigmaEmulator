require_relative 'rotors'

#convert all characters to integer values, offset by 65 (assumes uppercase)

def charToNum(letter)
    return letter.upcase.ord-65 #ensure this is uppercase???
end

#convert all int vals to characters

def numToChar(number)
    return (number+65).chr
end

#convert all strings passed in into a perutations array. this resembles the cycle notation. Done in this fashion to
#properly emulate the group theory studied w/o being confusing as heck...

def stringToPerms(rotor)
    outPerms = Array.new
    numsUsed = Array.new
    subPerms = Array.new
    i = 0

    while numsUsed.length < 26 do
        if (!numsUsed.include?(i)) then
            numsUsed.push(i)
            subPerms.push(i)
            i = charToNum(rotor[i])
            
            if(numsUsed.length >= 26) then
                outPerms.push(subPerms)
            end
        else
            outPerms.push(subPerms)
            subPerms = Array.new
            for n in 0...26 do
                if(!numsUsed.include?(n)) then
                    i = n
                    break
                end
            end
        end
    end

    return outPerms
end

#pass in a message and an enigma configuration
#should cycle through each character of the message, encode it then invers encode it through the
#reflector and back again. maybe use different functions for each rotor?? IDK
#as a first pass, write it as a 1 to 1, no rotations of the rotors thing.

def encode(message, rotors) #add a parameter for setting the rotation variation in here
    
    outString = ""
    for i in 0..message.length-1
        puts message[i]
        outChar = charToNum(message[i])
        rotors.each do |rotor|
            outChar = searchPerm(rotor, outChar, true)
        end
        outString << numToChar(outChar)
    end
    return outString
end

rotor1 = stringToPerms("EKMFLGDQVZNTOWYHXUSPAIBRCJ")
rotor2 = stringToPerms("AJDKSIRUXBLHWTMCQGZNPYFVOE")
rotor3 = stringToPerms("BDFHJLCPRTXVZNYEIWGAKMUSQO")
rotor4 = stringToPerms("ESOVPZJAYQUIRHXLNFTGKDCMWB")
rotor5 = stringToPerms("VZBRGITYUPSDNHLXAWMJQOFECK")

rotors = [rotor1, rotor2, rotor3, rotor4, rotor5]
rotorFlip = [charToNum("Q"), charToNum("E"), charToNum("V"), charToNum("J"), charToNum("Z")]

reflectorA = stringToPerms("EJMZALYXVBWFCRQUONTSPIKHGD")
reflectorB = stringToPerms("YRUHQSLDPXNGOKMIEBFZCWVJAT")
reflectorC = stringToPerms("FVPJIAOYEDRZXWGCTKUQSBNMHL")

reflector = [reflectorA, reflectorB, reflectorC]

#puts encode("HELLO", [rotor1, rotor2, rotor3])
puts encode("IPNNY", [rotor3, rotor2, rotor1])
