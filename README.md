# Knuth–Morris–Pratt string searching algorithm (or KMP algorithm) with Swift

<h1> Description </h1>
• Knuth–Morris–Pratt algorithm is an efficient string search algoritm with running time O(n + m) <br>
• This project implements the KMP in Swift using a String extension class. So, using the KMP.swift
  class, a given pattern can be matched in a string finding its first ocurrence on the text. <br>
• Knuth–Morris–Pratt algorithm consist on consist on creating a swift table for a given pattern, and
  according to the values obtained from that table, we can match the first ocurrence of a pattern against
  a string. 
<h1> Examples </h1>
• Let's assume that we have the pattern string "ccanna", and we need to find the first ocurrence of this pattern
  in the string "canccanccannca" by using KMP algoritm . Then first step is to create a swift table for the pattern
  with the following algoritm 
  
  ```
      i = 1, j = 0
      swift_table[0] == 1 // because char at i + j and char at j are the same
      while (i + j< m) // m is the length of the pattern
      {
          if (p[i + j] == p[j]) // char at i+j is same char as char at j
          {
              swift_table[i+j] = i
              j++
          }
          else {
              if (j==0) {
                 swift_table[
              }
          
          }
      
      }
      
      
  ```

<h1> Installation </h1>
• Copy and paste KMP.swift file into your project directory.

<h1> Usage </h1>
• These are some examples implementing the KMP String extension.<br>
```swift
   // matched = true, fromIndex = 15, toIndex = 18 
   "this is a string to be matched".matchWithKMP(forPattern: "g to") 
   
   // matched = true, fromIndex = 7, toIndex = 2
   "🚕🚕🚖🚖🚀🚏🚤🚅🚅🚅🚝🚤🚔".matchWithKMP(forPattern: "🚅🚅🚅") 
   
   // matched = false, fromIndex = -1, toIndex = -1
   "this is a string to be matched".matchWithKMP(forPattern: "astring") 
   
   // making sure it matches.
   let firstOcurrence = "this is a string to be matched".matchWithKMP(forPattern: "a string")
   if (firstOcurrence.matched)
   {
       // First ocurrence of pattern found in string
       let fromIndex = firstOcurrence.fromIndex
       let toIndex = firstOcurrence.toIndex
       print("First ocurrence found from index: \(fromIndex) to index \(toIndex)") // found from index 8 to 15
   }
   else
   {
       print("Pattern not found in string")
   }
   
```

