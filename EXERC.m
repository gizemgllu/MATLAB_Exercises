
%% Interpolation. Newton interpolating polynomial


%% Example 1. Newton interpolating polynomial 
clc, clearvars, format compact 
xnodes = (1:7);  ynodes = [2.3,3.4,5.1,6.3,7.5,8.2,7.4]; 
 coecoef = ynodes;
for k = 2:7
   coef(k:7) = (coef(k:7) - coef(k-1:6))./...
              (xnodes (k:7) - xnodes (1:8-k));
end


syms x
pol = coef(7); 
for k = 6:-1:1
    pol = pol*(x-xnodes(k))+coef(k);
end 

polyn(x) = collect(pol) 
coefpol = sym2poly(polyn)

x_pr = 1:0.01:7;
plot(x_pr,polyn(x_pr),'r-',xnodes,ynodes,'ob','LineWidth',3)
title('Newton interpolating polynomial')
legend('polynomial','nodes'), grid on
fun_prob3(coefpol)

%%  Example 2. Newton interpolating polynomial 
clc, clearvars, format compact, close all 
syms x
y = @(x)log(1+x.^2);
xnodes = (0:3);  ynodes = y(xnodes); 

x_pr = 0:0.01:3;
plot(x_pr,polyn(x_pr),'r-',x_pr,y(x_pr),'k--',xnodes,ynodes,'ob',...  
    'LineWidth',3)
title('Newton interpolating polynomial')
legend('polynomial','y = ln(1+x^2)','nodes') , grid on
fun_prob3(coefpol)

plot(x_pr,y(x_pr)-polyn(x_pr),'g:','LineWidth',3)
title('Interpolation error'), grid on

x1 = 0:0.01:10; plot(x1,polyn(x1),'r-',x1,y(x1),'k--','LineWidth',3)
title('x outside interpolation interval')
legend('polynomial','y = log(1+x^2)'), grid on


%% Example 3. Newton interpolating polynomial 
clc, clearvars, format compact, close all 
syms x, f = @(x)sqrt(2+x.^7);
xnodes = (1:5); ynodes = f(xnodes);  coef = ynodes;
for k = 2:5
    coef(k:5) = (coef(k:5) - coef(k-1:4))./...
                (xnodes(k:5) - xnodes(1:6-k));
end
pol= coef(5); 
for k = 4:-1:1
   pol = pol*(x-xnodes(k))+coef(k);
end

polyn(x)=collect(pol)  
coefpol=sym2poly(polyn) 
int_res = double(polyn(2.5))   
f_res = f(2.5)                
int_error = abs(int_res-f_res) 


disp('Answer:')
disp(['1) koef_x^2 = ', num2str(coefpol(3))])
disp(['2) value of the interpolant at the point 2.5 = ', num2str(int_res)])
disp(['3) interpolation error at the point 2.5 = ', num2str(int_error)])
disp('4) interpolation error at the point x=3 = 0')
disp('since x=3 is one of the interpolation nodes')

%% Spline interpolation

%% Example 4. Spline interpolation
clc, clearvars, format compact, close all 
f = @(x)abs(x);
xnodes = linspace(-1,1,11); ynodes = f(xnodes); 
x = linspace(-1,1,200);
y = interp1(xnodes,ynodes,x,'spline');
plot(x,y,'r-',x,f(x),'k--',xnodes,ynodes,'ob','LineWidth',3)
legend('spline','y = abs(x)', 'nodes')
title('Spline interpolation')
grid on

figure
plot(x,f(x)-y,'g:','LineWidth',3)
title('Interpolation error')
grid on

%% Example 5. Spline interpolation
clc, clearvars, format compact, close all 
f = @(x)sqrt(2+x.^7);
xnodes = (1:5); ynodes=f(xnodes);
x0 = 2.5;
int_res=interp1(xnodes,ynodes,x0,'spline'),f_res=f(x0)
int_error=abs(int_res-f_res)

disp('Answer:')
disp(['1) the value of the spline at the point 2.5 = ', num2str(int_res)])
disp(['2) interpolation error at the point 2.5 = ', num2str(int_error)])
disp('3) interpolation error at the point 3 = 0, ')
disp('since x=3 is one of the interpolation nodes')

%% external functions %%  external functions  %%   external functions %%%%%%%%%%

function fun_prob3(koef) 
   m = length(koef);
   fprintf('\n Answer. \n  Newton interpolating polynomial of degree %.0f \n ',m-1)
   n = m-1;
   for i = 1:m
      if koef(i) < 0
        fprintf(' %.4fx^%.0f',koef(i),n)
      else
         fprintf(' +')
         fprintf('%.4fx^%.0f',koef(i),n) 
      end
      n = n-1;
   end
   fprintf('\n')
end

