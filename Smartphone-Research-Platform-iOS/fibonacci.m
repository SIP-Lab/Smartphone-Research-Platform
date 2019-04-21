function fib_sequence = fibonacci(n,t1,t2)

fib_sequence = zeros(1,n);

fib_sequence(1) = t1;
fib_sequence(2) = t2;

for i = 3:n
    
    fib_sequence(i) = fib_sequence(i-1) + fib_sequence(i-2);
    
end