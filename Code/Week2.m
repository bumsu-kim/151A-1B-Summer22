
d = 9; % d-digit mantissa
r = true; % rounding or chopping

% function handles
% "lambda"s

fadd = @(x, y) add_fl(x, y, d, r);
fmult = @(x, y) mult_fl(x, y, d, r);
fdiv = @(x, y) div_fl(x, y, d, r);
fsubt = @(x, y) subt_fl(x, y, d, r);
fpow = @(x, y) pow_fl(x, y, d, r);
ffl = @(x) fl(x, d, r);


%% sqrt(x*x + 1) - 1 example
x = 0.0001;
% subt_canc = @(x, d, r) add_fl(sqrt(add_fl(mult(x,x,d,r),1,d,r)), -1, d, r);
fprintf('fl(x) : %e\n', ffl(x));
fprintf('\tx * x : %e\n', fmult(x,x));
fprintf('\tx * x + 1: %e\n', fadd(fmult(x,x),1));
fprintf('\tsqrt( x * x + 1 ): %e\n', ffl(sqrt(fadd(fmult(x,x),1))));
fprintf('sqrt( x * x + 1 ) - 1:\t\t\t%e\n', fsubt(sqrt(fadd(fmult(x,x),1)),1));

fprintf('x*x / sqrt( x * x + 1 ) + 1:\t%e\n', fdiv(fmult(x,x),fadd(sqrt(fadd(fmult(x,x),1)),1)));

% fprintf('with default precision: %e\n', sqrt(x*x+1)-1);
fprintf('with default precision:\t\t\t%e\n', x*x/(sqrt(x*x+1)+1));


%% Nested Multiplication
% % Tail part of the Taylor expansion of exp(-x)
% % is -x^3/3! + x^4/4! - x^5/5! + ...
% 
% d = 6; % d-digit mantissa
% r = true; % rounding or chopping
% 
% fadd = @(x, y) add_fl(x, y, d, r);
% fmult = @(x, y) mult_fl(x, y, d, r);
% fdiv = @(x, y) div_fl(x, y, d, r);
% fsubt = @(x, y) subt_fl(x, y, d, r);
% fpow = @(x, y) pow_fl(x, y, d, r);
% ffl = @(x) fl(x, d, r);
% 
% x = 4.567;
% sol = exp(-x)-(1- x + x*x/2);
% fprintf('default precision:\t%e\n', sol);
% 
% tol = 1e-3;
% fx = 0;
% maxdegree = 30;
% for i = 3:maxdegree
%     if mod(i,2) == 0
%         fx = fadd(fx, fdiv(fpow(x,i), factorial(i)));
%     else
%         fx = fsubt(fx, fdiv(fpow(x,i),factorial(i)));
%     end
%     if(abs(fx - sol) < tol)
%         fprintf('stopped at i = %d\n', i);
%         fprintf('w/o nested mult (deg = %d)\t:\t%e\t(error = %e)\n', i, fx, abs(fx-sol));
%         break;
%     end
%     fprintf('w/o nested mult (deg = %d)\t:\t%e\t(error = %e)\n', i, fx, abs(fx-sol));
% end
% 
% fprintf('\n --------- start nested multiplication ---------- \n\n');
% 
% for maxdegree = 4:30
%     fx_nested = 1;
%     for i=maxdegree:-1:4
%         fx_nested = fsubt(1, fmult(fx_nested, fdiv(x,i)));
%     end
%     fx_nested = fmult(fx_nested, -fdiv(fpow(x,3),6));
%     if(abs(fx_nested - sol) < tol)
%         fprintf('stopped at maxdegree = %d\n', maxdegree);
%         fprintf('w/  nested mult (deg = %d)\t:\t%e\t(error = %e)\n', maxdegree, fx_nested, abs(fx_nested-sol));
%         break;
%     end
%     
%     fprintf('w/  nested mult (deg = %d)\t:\t%e\t(error = %e)\n', maxdegree, fx_nested, abs(fx_nested-sol));
%     
% end

%% Floating point arithmetic functions
% floating point approx
function y = fl(x, d, rounding)
% get sign and make x nonnegative
s = sign(x);
x = abs(x);
ex = zeros(size(x)); % ex = 0 if x is scalar
nonzeros = x>0;
N = 10^(d-1);
% get exp and mantissa
ex(nonzeros) = floor(log10(x(nonzeros)));
% x = 12,345 then log10(x) = 4.xx , because log10(10000) = 4, log10(100000) = 5
% ex = 4,   12,345 ---> 12.345 --> floor --> 12.000 --> 0.12 x 10^4
if rounding
    m = floor(x.*10.^(-ex)*N + 0.5)/N;
else
    m = floor(x.*10.^(-ex)*N)/N;
end
y = s.*m.*10.^ex;
end

% multiplication
function z = mult_fl(x,y,d,r)
% truncation
x = fl(x, d, r);
y = fl(y, d, r);
z = fl(x.*y, d, r);
end

% multiplication
function z = div_fl(x,y,d,r)
% truncation
x = fl(x, d, r);
yinv = fl(1./y, d, r);
z = fl(x.*yinv, d, r);
end

% integer power
function y = pow_fl(x,n, d, r)
x = fl(x, d, r); y = ones(size(x));
if n>0
    for i=1:n
        y = mult_fl(y,x, d, r);
    end
elseif n<0
    % not implemented because we don't need it
end
y = fl(y, d, r);
end

% fl( fl(x) + fl(y) )
% addition
function z = add_fl(x, y, d, r)
% truncation
x = fl(x, d, r);
y = fl(y, d, r);
z = fl(x+y, d, r);
end

% addition
function z = subt_fl(x,y, d, r)
% truncation
x = fl(x, d, r);
y = fl(y, d, r);
z = fl(x-y, d, r);
end