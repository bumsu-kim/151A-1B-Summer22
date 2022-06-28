x = 1:40;
% matlab is powerful, in particular, for this type of matrix computations
a = 1./x;
b = 1./(x.*x);
c = 20*exp(-x);
% notice that we didn't use any for/while loops above

% plot three sequences
figure();
hold on;
plot(x, a)
plot(x, b)
plot(x, c)
legend('a = 1/n', 'b = 1/n^2', 'c = 20exp(-n)', 'Location', 'best');
title('Three decaying sequences')
set(gca, 'YScale', 'log') % sets the y-axis scale to log