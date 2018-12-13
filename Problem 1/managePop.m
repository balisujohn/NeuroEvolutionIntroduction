%We want to keep the top performers in the population
function population = managePop(curr, mutVector)
    
    %Create a fitness score for each of the current members
    popSize = size(curr,1);
    fitness = zeros(popSize,1); %Make a column the size of curr
    breedingChances = zeros(popSize,1);
    totalFit = 0;
    numTotalBreed = popSize;
    
%% Fitness Calculation
    for i = 1:popSize
        %TODO implement fitness function
        currFit = fitnessTest(curr(i));
        
        %Keep track of individual fitness as well as total.
        totalFit = totalFit + currFit;
        fitness(i) = currFit;
    end
    
    manager = [curr,fitness];
%% Sort by Fitness
    %Create 'unfair' breeding - the top performant one gets most mating
    %Sort matrix by the fitness value
    [~,id] = sort(manager(:,4));
    manager = manager(id,:);

%% Calculate breed amount based on fitness
   %TODO Manage population considering score/totalscore * breedsize
   %Then breed, fitness function those, and select top 10 from all.
   actualTotalBreed = 0;
   for i = 1:popSize
       breedTimes = ceil(manager(i,4) / totalFit * numTotalBreed);
       actualTotalBreed = breedTimes + actualTotalBreed;
   end
   
   %add on breeding chances to our array.
   manager = [manager,breedingChances];

%% Create new Population
   %Use the breeding chances to calculate the children
   population = zeros(actualTotalBreeding*2,4); 
   %This is sized so that every breed will result in 2 children, 
   %and every creature in the population will need it's genome + fitness
   for i = 1:actualTotalBreed
       %Select 2 things to breed
       %Choose father
       selected = false;
       while(~selected) 
           r = rand;
           if(manager(ceil(r*popSize),5) > 0)
               father = manager(ceil(r*popSize,:));
               selected = true;
               %Now has one less chance to breed
               father(5) = father(5) - 1;
           end
       end
       %find mother. I could add a function, but Its finals week and I just
       %want this to work. 
       selected = false;
       while(~selected) 
           r = rand;
           if(manager(ceil(r*popSize),5) > 0)
               mother = manager(ceil(r*popSize,:));
               selected = true;
               %Now has one less chance to breed
               mother(5) = mother(5) - 1;
           end
       end
       
       [c1,c2] = crossover(mother, father, mutVector);
       
       %Add resultant to population matrix
       population(i*2-1) = c1;
       population(i*2) = c2;
       
    
   end
   
%% Calculate new pop fitness
for i = 1:actualTotalBreeding
        fitness(i) = fitnessTest(population(i));
end   

%% Sort array by fitness
[~,id] = sort(population(:,4));
population = population(id,:);

%% Split off fitness score return top X perfomers
%The 3 comes from the size of the genome. 
population = population(1:popSize,1:3);
    
    
    
    
    
         
        
    
    
    
