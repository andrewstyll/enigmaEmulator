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
