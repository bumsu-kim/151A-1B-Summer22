A = rand(3); % 3-by-3 square matrix of random entries
disp('A is ')
disp(A);     % displays A
 
x = [1;0;0]; % colummn vector
 
disp('A*x is ');
disp(A*x);   % displays A*x = (First column of A)
 
v = A(:);    % vectorize A
disp('A (vectorized) is');
disp(v);
 
n = size(v); % size of v (3*3 = 9)
 
for i = 2:n  % for i running from 2 to n
    v(i) = v(i) + v(i-1); % what is the result?
end
 
disp('cumulative sum is ');
disp(v);
 
% Plot v
figure(); plot(v); % multiple commands in a single line is allowed

