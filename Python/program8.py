#print the fibonacci series up to n terms
n=int(input("enter number:"))
a=0
b=1
print(a,b,end=" ")
for i in range(2,n):
    c=a+b
    print(c,end=" ")
    a=b
    b=c

'''
output:
enter number:9
0 1 1 2 3 5 8 13 21 
'''
   
