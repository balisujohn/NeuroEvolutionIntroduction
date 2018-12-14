%Have two vectors combine in a random order, simulating children from
%parents. Input is two arrays and a vector that describes how mutation
%works. Output is two arrays representing individuals. 
function [c1, c2] = crossover(m, f, mutateVector)
%% Build the children matrix
   % c1 = zeros(1,3);
   % c2 = zeros(1,3);
    
%% Randomly select parent
    %for i = 1:3
     %   r = rand;
     %   if(r > .5)
     %      c1(i) = m(i);
     %      c2(i) = f(i);
     %   else
     %      c1(i) = f(i);
     %      c2(i) = m(i);
     %   end
   % end
%% Build Children
    c1 = [m(1), f(2), f(3)];
    c2 = [f(1), m(2), m(3)];
    
%% Mutate Children
    c1 = mut(c1);
    c2 = mut(c2);
   
    
    