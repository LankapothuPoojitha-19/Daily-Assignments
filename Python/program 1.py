# Reverse a given string without using built-in reverse function
s=input("Enter a string:")
rev=""
for ch in s:
    rev=ch+rev
print(rev)

'''
Ouput:
Enter a string:hello
olleh
'''

