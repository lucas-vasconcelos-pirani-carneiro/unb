fatorial n = product [1..n]
fat n 
	| n == 0  || n==1  = 1     
	| n > 1            = n* fat (n-1)
