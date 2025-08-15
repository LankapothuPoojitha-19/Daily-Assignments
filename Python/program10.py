#reverse the digits of a given number
n=int(input("enter a number:"))
rev=0
while(n>0):
    rem=n%10
    rev=(rev*10)+rem
    n=n//10
print(rev)

'''
output:
enter a number:123
321
'''
