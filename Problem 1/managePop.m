%We want to keep the top performers in the population
function population = managePop(curr, mutVector)
    
    %Create a fitness score for each of the current members
    fitness = zeros(size(curr,1),1); %Make a column the size of curr
    breedingChances = zeros(size(curr,1),1);
    
    for i = 1:size(curr,1)
        %TODO implement fitness function
        fitness(i) = fitnessTest(curr(i));
        breedingChances(i) = ceil(i/3);
    end
    
    curr = [curr,fitness,breedingChances];

    %Create 'unfair' breeding - the top performant one gets most mating
    %Sort matrix by the fitness value
    [~,id] = sort(curr(:,4));
    curr = curr(id,:);
    
   %TODO Manage population considering score/totalscore * breesize
   %Then breed, fitness function those, and select top 10 from all. 
    
    
    
    
    
         
        
    
    
    
