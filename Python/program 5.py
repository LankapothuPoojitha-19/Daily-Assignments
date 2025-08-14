#Count the frequency of each character in a string
s=input("Enter a string:")
freq={}
for i in s:
    if i in freq:
        freq[i]+=1
    else:
        freq[i]=1
print(freq)

'''
Output:
Enter a string:artificial
{'a': 2, 'r': 1, 't': 1, 'i': 3, 'f': 1, 'c': 1, 'l': 1}
'''
