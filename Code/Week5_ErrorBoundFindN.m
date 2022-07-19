syms x
f = @(x) sin(x);

L = sym('L', [n+1,1]);
for n = 2:6
    % Do Lagrange Interpolation
    xdat = linspace(0,1,n+1);
    fdat = f(xdat);
    P = 0;
    for i=1:n+1
        L(i) = prod(x-xdat)/(x-xdat(i));
        L(i) = L(i)/subs(L(i),x,xdat(i));
        P = P + fdat(i)*L(i);
    end
    simplify(P);
    
    % Plot the functions and the error
    figure();
    subplot(1,2,1); % functions on the left
    fplot(P, [0,1]);
    hold on;
    fplot(sin(x), [0,1]);
    legend('P', 'sin');
    title(['n = ',num2str(n)]);

    subplot(1,2,2); % error in semi-log-y scale, on the right
    fplot(abs(P-sin(x)), [0,1]);
    set(gca,'YScale','Log');
    title(['n = ',num2str(n)]);
end