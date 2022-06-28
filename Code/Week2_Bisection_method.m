%% Bisection method
% function handle (Ctrl+R/T to comment/uncomment)
% f = @(x) x.^2-2; % finds +-sqrt(2)
f = @(x) sin(x); % finds an interger multiple of pi
% f = @(x) g(x, pi);     % can be an arbitrary function g defined later
                       % here g may accept more than 1 arguments
                       % but note that f is still a ftn of single variable

% initial interval of estimation: [a, b]
a = 0; b = 7;
% target accuracy: eps
eps = 1e-14;

sol = bisection(f, a, b, eps);

%% plot f(x)
% create a vector x = [a, a+h, a+2h, ..., b] of size N+1
%                 where h = (b-a)/N
N = 1000; x = linspace(a, b, N+1); 

% function handle must be able to do entry-wise evaluation
fval = f(x);

% plot f on [a,b]
plot(x, fval);

% plot the solution with a *-shaped marker
hold on; plot(sol, f(sol), '*');


%% Helper Function Definitions
function y = g(x1, x2)
y = cos(x1) + sqrt(x2+1)- 3*x1*x2;
end

function x = bisection(f, a, b, eps)
% INPUT
% f ...... function handle
% a, b ... Initial interval of estimation
% eps .... target accuracy
% -------------------
% OUTPUT
% x ...... estimated solution

% store function values at a and b
fa = f(a);
fb = f(b);
if sign(fa)*sign(fb) >= 0
    disp('ERROR: Invalid interval');
    x=0;
    return;
end

while (b-a > eps)
    c = (a+b)/2;
    fc = f(c);
    if sign(fa)*sign(fc) < 0 % x in [a,c]
        % update the right endpoint
        b = c;
    else % x in [c,b]
        % update the left endpoint and the f value at that point
        a = c;
        fa = fc; % Q: why is this required only in this else cluase?
    end
end
x = (a+b)/2; % return the midpoint

% print output with 16 significant digits
disp(['a = ', num2str(a, 16)])
disp(['b = ', num2str(b, 16)])
disp(['x = ', num2str(x, 16)])
disp(['err <= ', num2str(b-x, 16)]);
end



