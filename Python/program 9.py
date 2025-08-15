#find the sum of digits of a given number
n=int(input("enter a number:"))
sum=0
while n>0:
    rem=n%10
    sum=sum+rem
    n=n//10
print("Sum of digits:",sum)

'''
output:
enter a number:123
Sum of digits: 6
'''
