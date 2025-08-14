#check if a string is palindrome or not
s=input("Enter a string:")
if s==s[::-1]:
    print("Palindrome")
else:
    print("Not a Palindrome")

'''
Output:
Enter a string:madam
Palindrome
Enter a string:user
Not a Palindrome
'''
