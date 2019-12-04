
% Write a predicate to determine the lowest common multiple of a list
% formed from integer numbers.
%cmmdc(a,b)= a, a=b
%            cmmdc(a-b, b), a>b
%            cmmdc(a, b-a), b>a
%(i,i, o)
cmmdc(A,B,R):- A<B, cmmdc(A,B-A,Rs), R is Rs.
cmmdc(A,B,R):- A>B, cmmdc(A-B,B,Rs), R is Rs.
cmmdc(A,B,R):- A=:=B, R is A.
% cmmmc(l1,l2,...,ln)=l1*cmmmc(l2,...,ln)/cmmdc(l1,cmmmc(l2,..,ln)),n!=0
%                     1, n=0
%(i,o)
cmmmc([],1).
cmmmc([H|T],R):- cmmmc(T, Rs), cmmdc(H,Rs,X), R is H*Rs/X.


% Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, …
% element in a list
%
%isPower(n) = true, n=1
%             false, n odd
%             isPower(n/2), n even
%(i)
isPower(1):- true.
isPower(N):- (N mod 2)=:=1, false.
isPower(N):- (N mod 2)=:=0,N1 is N/2, isPower(N1).
%addValue(l1,...,ln, v, i) = empty list, n=0
%                           l1 U v U addValue(l2,..,ln,v, i+1), if i=
%                                    2^x, x natural number
%                           addValue*l2,..., ln, v, i+1), otherwise
%(i,i,i,o)
addValue([],_,_,[]).
addValue([H|T],V,I,[H,V|Rez]):- isPower(I), I2 is I+1, addValue(T, V, I2, Rez).
addValue([H|T],V,I,[H|Rez]):- not(isPower(I)), I2 is I+1, addValue(T, V, I2, Rez).


main([H|T],V):- addValue([H|T],V,1,R), write(R),!.







