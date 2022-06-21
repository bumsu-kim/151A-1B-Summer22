e = machine_eps(100); % run machine_eps function with max_iter = 100

%% The Below is the Function Definition of machine_eps

% Syntax: 
% function [return_value] = [function_name] ( [parameters] )
function eps = machine_eps(max_iter)
eps = 1; % start from 1

% for loop,
% looping through i = 1, 2, 3, ... max_iter
% (or until "break")
for i = 1:max_iter
    if ( 1 + eps/2 == 1)
        break;
    else
        eps = eps / 2;
    end % indicates the end of if-else clause
end     % indicates the end of the for loop

% display output
disp(['machine eps = ', num2str(eps)]);
disp([ ' = 2^(-' , num2str(i-1), ')']);
% or you can use "fprintf" if you prefer
%fprintf('machine eps = %.4e = 2^(-%d)\n', eps, i-1);
end
