%Generate an initial population that lies within the mutVectors range.
function pop = popGen(mutVector, size)
pop = zeros(size,3);

for i = 1:size
    %Roll each gene separately
    for j = 1:3
        %The jth gene corresponds to the j+1th mut element.
        pop(i,j) = rand * mutVector(j+1);
    end
end

