% Implement the Newton's method
function x = Newton(x0, f, df, maxIter, eps)
% NOTE: eps-accurate solution in this implementation does not imply
%       |x-x*| < eps
% But we will find the solution such that |f(x)| < eps
x = zeros(maxIter+1,1);
x(1) = x0;
% x_star = 25^(1/3);
for i = 1:maxIter
    x(i+1) = x(i) - f(x(i))/df(x(i));
    fprintf('%.12e\n', x(i+1));
    if(abs(f(x(i+1))) < eps)
%     if( abs ( x- x_star) < eps )
        break;
    end
end
x = x(1:(i+1));
fprintf('Newton''s method converged after %d iterations with f(x) = %e\n', i, f(x(i+1)) );
end