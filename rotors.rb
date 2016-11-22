#gets the permutation of a rotor given a character 
#each rotor is a permutation composed of disjoint sets

def getPerm(permSet, char)
    for i in 0..permSet.length
        if(char == permSet[i]) 
            if(i == permSet.length-1)
                return permSet[0]
            else
                return permSet[i+1]
            end
        end
    end
end

def getPermInv(permSet, char)
    for i in 0..permSet.length
        if(char == permSet[i]) 
            if(i == 0)
                return permSet[permSet.length-1]
            else
                return permSet[i-1]
            end
        end
    end
end

def searchPerm(rotor, char, inverse)
    rotor.each do |set|
        if(set.include? char)
            return inverse ? getPermInv(set, char) : getPerm(set, char)
        end
    end
    return char
end

#I need notch position, starting rotor position, current letter count, ring positions

def makeKeys(charIndex, rotorPos, rotorNotch, ringPos)
    rStepCtrl1 = (rotorNotch[0] - rotorPos[0] - 1)%26
    rStepCtrl = (rotorNotch[1]-rotorPos[1] - 1)%26
    rStepCtrl2 = rStepCtrl1 + 1 + 26*(rStepCtrl)

    rMove1 = (charIndex - rStepCtrl1+26)/26
    rMove2 = (charIndex - rStepCtrl2+650)/650
    rMove1 = (rMove1>0) ? rMove1.floor : rMove1.ceil
    rMove2 = (rMove2>0) ? rMove2.floor : rMove2.ceil


    key0 = (rotorPos[0] - ringPos[0] + 1) + charIndex
    key1 = rotorPos[1] - ringPos[1] + rMove1 + rMove2
    key2 = rotorPos[2] - ringPos[2] + rMove2
    
    keys = [key0, key1, key2]

    return keys
end
