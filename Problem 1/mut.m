%mutVector will contain the [chanceToMutate, randMultiplier1,
%randMultiplier2, randMultiplier3]. Input will contain some individual, and
%the output will be some individual. 
function genome = mut(genome)
%% Mutate
global mutVector;
    if(rand < mutVector(1))
        %If we are mutating, mutate one variable with equal chance.
        randomGene = rand;
        if(randomGene < (1/3))
            genome(1) = rand * mutVector(2);
        elseif(randomGene < (2/3))
            genome(2) = rand * mutVector(3);
        else
            genome(3) = rand * mutVector(4);
        end
    end
                
                
        
    