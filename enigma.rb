#first step, convert all rotors to permutations of the rotors

def charToNum(letter)
    return letter.ord-65 #ensure this is uppercase???
end

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

rotor1 = stringToPerms("EKMFLGDQVZNTOWYHXUSPAIBRCJ")
rotor2 = stringToPerms("AJDKSIRUXBLHWTMCQGZNPYFVOE")
rotor3 = stringToPerms("BDFHJLCPRTXVZNYEIWGAKMUSQO")
rotor4 = stringToPerms("ESOVPZJAYQUIRHXLNFTGKDCMWB")
rotor5 = stringToPerms("VZBRGITYUPSDNHLXAWMJQOFECK")
