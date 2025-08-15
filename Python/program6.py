#check if a number is prime or not
n=int(input("Enter a number:"))
count=0
for i in range(1,n+1):
    if n%i==0:
        count+=1
if(count==2):
    print("prime")
else:
    print("not prime")

'''
Output:
Enter a number:10
not prime
Enter a number:11
prime

'''
