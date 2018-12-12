%We will input 2 arrays of size 3 that will have a genome of size 3, and
%create two children. 

function [c1, c2] = crossover(m, f, mutateVector)
    %We will use a 3 genome for this
    %The first will be speed, second will be jump chance, and third will be
    %jump distance.
    
    %Create two children
    c1 = mut([m(1), f(2), f(3)], mutateVector)
    c2 = mut([f(1), m(2), m(3)], mutateVector)
   
    
    