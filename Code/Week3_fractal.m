%%
% Credits:
% 
% Written by 남웅식 
% as a HW in MAS365 Intro to Numerical Analysis (Spring 2016) in KAIST
% (Original comments in Korean are removed)

x=(-2:0.01:2);
y=(2:-0.01:-2);      
[X,Y]=meshgrid(x,y); 
Z1=X+1i*Y;           
Z2=Z1;               
Z3=Z1;               
Z4=Z1;

N=150; % # of iteration
r1=max(1,2); % Threshold radius 
r2=max(abs(-0.1+0.8*1i),2); 
count1=zeros(max(size(Z1)));  
count2=zeros(max(size(Z2)));  
count4=zeros(max(size(Z4)));

for k=1:N
    Z1=Z1.^2-1;                 
    count1=count1+(abs(Z1)<r1); 
    
    
    Z2=Z2.^2+(-0.1+0.8i);       
    count2=count2+(abs(Z2)<r2);
    
    Z3=(1+2*1i)*exp(Z3);        
    
    Z4=(2*pi*1i)*exp(Z4);
    count4=count4+(1-(isnan(Z4)));
    
end


map = [1 0 0 % red
    1 0.5 0  % orange
    1 1 0    % yellow
    0 1 0    % green
    0 0 1    % blue   
    0.29 0 0.51 % indigo
    0.56 0 1    % violet
    0 0 0];     % black
colormap(map) 


subplot(2,2,1)  
title('(a) : Q(z)=z^2-1')
imagesc([-2 2],[2 -2],count1) 
set(gca, 'YDir','normal')     
axis equal                    
colorbar

subplot(2,2,2)                
title('(b) : Q(z)=z^2-0.1+0.8i')
imagesc([-2 2],[2 -2],count2)
set(gca, 'YDir','normal')
axis equal;
colorbar

subplot(2,2,3)
title('(c) : Q(z)=(1+2i)e^z')  
abs_Z3=abs(Z3);              
abs_Z3(isnan(abs_Z3))=4;     
imagesc([-2 2],[2 -2],abs_Z3)                           
set(gca, 'YDir','normal')   
axis equal;
colorbar

subplot(2,2,4)
title('Q(z)=2pi*i*e^z')
imagesc([-2 2],[2 -2],count4)
set(gca, 'YDir','normal')
axis equal;
colorbar

