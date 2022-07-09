%% Aitken's method
g = @(x) cos(x);

% find the fixed point
fp = 0.5;
for i = 1:100
    fp = g(fp);
end

% Generate a sequence
N = 30;
p = zeros(N,1);
p(1) = 0.5; % initial
for i = 2:N
    p(i) = g(p(i-1));
end

% Aitken's acceleration method
numerator = p(3:end).*p(1:end-2) - p(2:end-1).^2;
denominator = p(3:end) - 2*p(2:end-1) + p(1:end-2);
p_acc = numerator./denominator;

% Plot
figure(); hold on;
plot(abs(p-fp));
plot(abs(p_acc-fp));
legend('Original Seq', 'Accelerated Seq');
set(gca, 'YScale', 'Log');
title('Original vs Accelerated');
xlabel('num. of iterations')
ylabel('Absolute Error (log-scale)')