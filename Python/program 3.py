#count the number of vowels and consonants in a string
s=input("Enter a string:")
vowels="aeiouAEIOU"
vowel_count=0
consonant_count=0
for i in s:
    if('a'<=i<='z')or('A'<=i<='Z'):
        if i in vowels :
            vowel_count+=1
        else:
            consonant_count+=1
print("Vowels:",vowel_count)
print("Consonants:",consonant_count)

'''
Output:
Enter a string:hello world
Vowels: 3
Consonants: 7
'''
