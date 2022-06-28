g1 = @(x) x*(1+(7- x^5)/x^2)^3;
g2 = @(x) x - (x^5-7)/x^2;
g3 = @(x) x - (x^5-7)/(5*x^4);
g4 = @(x) x - (x^5-7)/12;

MaxIter = 10;

p0 = 1;
a = zeros(MaxIter, 1); pa = p0; a(1) = pa;
b = zeros(MaxIter, 1); pb = p0; b(1) = pb;
c = zeros(MaxIter, 1); pc = p0; c(1) = pc;
d = zeros(MaxIter, 1); pd = p0; d(1) = pd;


for i = 2:MaxIter
    pa = g1(pa); a(i) = pa;
    pb = g2(pb); b(i) = pb;
    pc = g3(pc); c(i) = pc;
    pd = g4(pd); d(i) = pd;
end

sol = 7^(1/5);
figure();
hold on;
% plot(1:MaxIter, abs(a-sol));
% plot(1:MaxIter,abs(b-sol));
plot(1:MaxIter,abs(c-sol));
plot(1:MaxIter,abs(d-sol));
legend('a', 'b', 'c', 'd');
 set(gca, 'YScale', 'log')