function child = crossover(mother, father)
    %Make sure that we have the bigger one being the mother for consistency
    if(len(father) > len(mother)
        placeholder = father;
        father = mother;
        mother = placeholder;
    end
    
    %Set up the section for crossover
    %For this first test, we are going to try to switch the center square
    %of the father into the mother. 
    
