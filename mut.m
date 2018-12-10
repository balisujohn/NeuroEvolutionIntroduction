%mutVector will contain the [chanceToMutate, randMultiplier1,
%randMultiplier2, randMultiplier3]
function genome = mut(genome, mutVector)
    %Set a hardcoded chance for something to mutate
    mutChance = mutVector(1);
    
    %Mutate with a percent chance.
    if(rand < mutChance)
        randomGene = rand;
        if(randomGene < (1/3))
            genome(1) = rand * mutVector(2);
        elseif(randomGene < (2/3))
            genome(2) = rand * mutVector(3);
        else
            genome(3) = rand * mutVector(4);
        end
    end
                
                
        
    