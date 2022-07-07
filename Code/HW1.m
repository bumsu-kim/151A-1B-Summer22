%% Problem 1
disp(' ');
disp('==== Problem 1 ====');
% f(x) = 1.01*exp(4*x) - 4.62*exp(3*x) - 3.11*exp(2*x) + 12.2*exp(x) - 1.99

d = 3; % 3-digit
r = true; % rounding

fval = f(1.53);
faval = fa(1.53, d, r);
fbval = fb(1.53, d, r);
fprintf(  'f val    = %4f\n\nf val(a) = %4f\nf val(c) = %4f\n', fval, faval, fbval);
fprintf('\nerror(a) = %4f\nerror(c) = %4f\n', fval-faval, fval-fbval);

%% Helper functions

function y = f(x)
 y = 1.01*exp(4*x) - 4.62*exp(3*x) - 3.11*exp(2*x) + 12.2*exp(x) - 1.99;
%  y = fl3(y);
end

function y = fa(x, d, r)
t1 = mult( 1.01, pow(fl(exp(x), d, r), 4, d, r), d, r);
t2 = mult( -4.62, pow(fl(exp(x), d, r), 3, d, r), d, r);
t3 = mult( -3.11, pow(fl(exp(x), d, r), 2, d, r), d, r);
t4 = mult( 12.2, fl(exp(x), d, r), d, r);
t5 = fl(-1.99, d, r);

y = add_fl(add_fl(add_fl(add_fl(t1, t2, d, r), t3, d, r), t4, d, r), t5, d, r);
end

function y = fb(x, d, r)
y =  mult(fl(exp(x), d, r), 1.01, d, r);
y = add_fl(-4.62, y, d, r);
y = mult(fl(exp(x), d, r), y, d, r);
y = add_fl(-3.11, y, d, r);
y = mult(fl(exp(x), d, r), y, d, r);
y = add_fl(12.2, y, d, r);
y = mult(fl(exp(x), d, r), y, d, r);
y = add_fl(-1.99, y, d, r);
end

% Define d-digit rounding/chopping mantissa operations

% floating point approx
function y = fl(x, d, rounding)
% get sign and make x nonnegative
s = sign(x);
x = abs(x);
ex = zeros(size(x));
nonzeros = x>0;
N = 10^(d-1);
%get exp and mantissa
ex(nonzeros) = floor(log10(x(nonzeros)));
if rounding
    m = floor(x.*10.^(-ex)*N + 0.5)/N;
else
    m = floor(x.*10.^(-ex)*N)/N;
end
y = s.*m.*10.^ex;
end

% multiplication
function z = mult(x,y,d,r)
% truncation
x = fl(x, d, r);
y = fl(y, d, r);
z = fl(x.*y, d, r);
end


% integer power
function y = pow(x,n, d, r)
x = fl(x, d, r); y = ones(size(x));
if n>0
    for i=1:n
        y = mult(y,x, d, r);
    end
elseif n<0
    % not implemented because we don't need it
end
y = fl(y, d, r);
end

% addition
function z = add_fl(x,y, d, r)
% truncation
x = fl(x, d, r);
y = fl(y, d, r);
z = fl(x+y, d, r);
end