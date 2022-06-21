e = machine_eps(100); % run machine_eps function with max_iter = 100

function eps = machine_eps(max_iter)
eps = 1;
for i = 1:max_iter
    if ( 1 + eps/2 == 1)
        break;
    else
        eps = eps / 2;
    end
end
disp(['machine eps = ', num2str(eps)]);
disp([ ' = 2^(-' , num2str(i-1), ')']);
% or you can use "fprintf" if you prefer
% fprintf('machine eps = %.4e = 2^(-%d)\n', eps, i-1);
end
