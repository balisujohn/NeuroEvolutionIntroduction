%We want to keep the top performers in the population
function population = managePop(curr, mutVector)
    
    %Create a fitness score for each of the current members
    fitness = zeros(size(curr,1),1); %Make a column the size of curr
    breedingChances = zeros(size(curr,1),1);
    
    for i = 1:size(curr,1)
        %TODO implement fitness function
        fitness(i) = fitnessTest(curr(i));
    end
    
    curr = [curr,fitness];

    %Create 'unfair' breeding - the top performant one gets most mating
    %Sort matrix by the fitness value
    [~,id] = sort(curr(:,4));
    curr = curr(id,:);
    
    
    
    
         
        
    
    
    
