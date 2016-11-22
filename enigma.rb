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

def encodeMessage(message, rotors, reflector, rotorPos, rotorNotch, ringPos) #add a parameter for setting the rotation variation in here
    
    outString = ""
    spaceOffset = 0 #to ignore spaces. This is unrealistic, but makes messages easier to read. I'd never make it in the army...
    for i in 0...message.length
        outChar = charToNum(message[i])
        
        if outChar < 0 || outChar > 25 
            spaceOffset += 1
            outString << message[i]
            next
        end

        keys = makeKeys(i-spaceOffset, rotorPos, rotorNotch, ringPos)
        
        for j in 0...rotors.length
            outChar = (outChar+keys[j])%26
            outChar = searchPerm(rotors[j], outChar, false)
            outChar = (outChar-keys[j])%26
        end
        
        outChar = searchPerm(reflector, outChar, false)

        for j in (rotors.length-1).downto(0)
            outChar = (outChar+keys[j])%26
            outChar = searchPerm(rotors[j], outChar, true)
            outChar = (outChar-keys[j])%26
        end

        outString << numToChar(outChar)
    end
    return outString
end
