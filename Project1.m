% APPM 2360 Mortgage Project - 2/27/2021
% Andrew Logue
% Anna Hendricks

clear
close all
clc

%% 3.1 

r = 0.03; % interest rate (%)
A_0 = 750000; % origional loan ($)
syms t % time (years)

% plot
figure(1)
hold on
% for n = 4
A(t) = A_0*(1+(r/4))^(4*t);
fplot(A(t), [0 30])
% for n = 12
A(t) = A_0*(1+(r/12))^(12*t);
fplot(A(t), [0 30])
% compounding continuosly
A(t) = A_0*exp(r*t);
fplot(A(t), [0 30])

title('Compounded Interest of $750,000 Loan Over 30 Years')
xlabel('Number of Years')
ylabel('Total Cost ($)')
legend('Compounded Every 3 Months', 'Compounded Every 12 Months', ...
    'Compounded Continuosly')


%% 3.2.1 Fixed Rate Mortgage

r = 0.05; % interest rate (%)
p = 4000; % monthly payment ($)
A = 750000; % mortgage ($)
h = 0.5; % step size
i = 1; % indexer
syms t % time (years)

% output Vector
V(i) = A;
% compute money owed after time t
% assume that at the first instance the mortgage becomes negative,
% it has been paid of and is therefore $0
while A > 0
    A = A + h*(r*A - 12*p);
    i = i+1;
    V(i) = A;
end

% calculate and print when modeled mortgage will be payed off
t_f = interp1(V, 0:h:((length(V) - 1)*h), 0);
fprintf('For a model with h = 0.5, the $750,000 mortgage will be payed off in: %.4f years\n', t_f);

% plot
figure(2)
hold on
% numerical solution
plot(0:h:((length(V) - 1)*h), V)
% true solution
A_true(t) = ((12*p)/r) + (750000 - ((12*p)/r))*exp(r*t);
fplot(A_true(t), [0 31])

title('Time to Pay Off Mortgage')
xlabel('Number of Years')
ylabel('Cost of Mortgage Paid ($)')
ylim([0 800000])
legend('Numerical Solution (h = 0.5)', 'True Solution')

% for true value
x = 0:0.00001:31;
t_f = interp1(((12*p)/r) + (750000 - ((12*p)/r))*exp(r*x), x, 0);
fprintf('For the true solution, the $750,000 mortgage will be payed off in: %.4f years\n', t_f);

clear 

r = 0.05; % interest rate (%)
p = 4000; % monthly payment ($)
A = 750000; % mortgage ($)
h = 0.01; % step size
i = 1; % indexer
syms t % time (years)

% output Vector
V(i) = A;
% compute money owed after time t
% assume that at the first instance the mortgage becomes negative,
% it has been paid of and is therefore $0
while A > 0
    A = A + h*(r*A - 12*p);
    i = i+1;
    V(i) = A;
end

% calculate and print when modeled mortgage will be payed off
t_f = interp1(V, 0:h:((length(V) - 1)*h), 0);
fprintf('For a model with h = 0.01, the $750,000 mortgage will be payed off in: %.4f years\n', t_f);

% plot
figure(3)
hold on
% numerical solution
plot(0:h:((length(V) - 1)*h), V)
% true solution
A_true(t) = ((12*p)/r) + (750000 - ((12*p)/r))*exp(r*t);
fplot(A_true(t), [0 31])

title('Time to Pay Off Mortgage')
xlabel('Number of Years')
ylabel('Cost of Mortgage Paid ($)')
ylim([0 800000])
legend('Numerical Solution (h = 0.01)', 'True Solution')

% for true value
x = 0:0.00001:31;
t_f = interp1(((12*p)/r) + (750000 - ((12*p)/r))*exp(r*x), x, 0);
fprintf('For the true solution, the $750,000 mortgage will be payed off in: %.4f years\n', t_f);

%% 3.2.2 Adjustable Rate Mortgage

r = 0.03; % interest rate (%)
p = 4000; % monthly payment ($)
A = 750000; % mortgage ($)
h = 0.01; % step size
i = 1; % indexer
syms t % time (years)
totalInterest = 0; % ($)

% output Vector
V(i) = A;
% compute money owed after time t
% assume that at the first instance the mortgage becomes negative,
% it has been paid of and is therefore $0
while A > 0
    % interest rate remains 3% until past year 5
    if (i-1)*h <= 5
        A = A + h*(r*A - 12*p);
    else
        A = A + h*((r + 0.015*sqrt(i*h - 5))*A - 12*p);
    end
    i = i+1;
    V(i) = A;
    
end

% calculate and print the total amount of interest
totalInterest = p*((h*(i-1))*12) - 750000;
fprintf('Amount of interest paid with $4000 monthly payments: $%.2f \n', totalInterest);
% calculate and print when modeled mortgage will be payed off
t_f = interp1(V, 0:h:((length(V) - 1)*h), 0);
fprintf('With $4,000 monthly payments, the $750,000 mortgage will be payed off in: %.4f years\n', t_f);

% plot
figure(4)
hold on
% for $4000 monthly payments
plot(0:h:((length(V) - 1)*h), V)

clear
r = 0.03; % interest rate (%)
p = 4500; % monthly payment ($)
A = 750000; % mortgage ($)
h = 0.01; % step size
i = 1; % indexer
syms t % time (years)
totalInterest = 0; % ($)

% output Vector
V(i) = A;
% compute money owed after time t
% assume that at the first instance the mortgage becomes negative,
% it has been paid of and is therefore $0
while A > 0
    % interest rate remains 3% until past year 5
    if (i-1)*h <= 5
        A = A + h*(r*A - 12*p);
    else
        A = A + h*((r + 0.015*sqrt(i*h - 5))*A - 12*p);
    end
    i = i+1;
    V(i) = A;
    
end

% calculate and print the total amount of interest
totalInterest = p*((h*(i-1))*12) - 750000;
fprintf('Amount of interest paid with $4500 monthly payments: $%.2f \n', totalInterest);
% calculate and print when modeled mortgage will be payed off
t_f = interp1(V, 0:h:((length(V) - 1)*h), 0);
fprintf('With $4,500 monthly payments, the $750,000 mortgage will be payed off in: %.4f years\n', t_f);
% plot
figure(4)
hold on
% for $4500 monthly payments
plot(0:h:((length(V) - 1)*h), V)

title('Time to Pay Off Mortgage')
xlabel('Number of Years')
ylabel('Cost of Mortgage Paid ($)')
ylim([0 800000])
legend('$4000 Monthly Payment', '$4500 Monthly Payment')

