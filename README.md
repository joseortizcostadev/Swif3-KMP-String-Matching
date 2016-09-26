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
    /// Assign values to a KMP Swift table which will be used to match ocurrences with the text
    /// - Parameter pattern: the pattern to be matched.
    /// - Returns: A list of SwiftTableContent structs that represents the swift table
    ///
    /// -Note:
    ///  For the pattern "ccannc" this method will return a list of structs representing
    ///  the following table
    ///
    /// ----------------------------------
    /// | index || 0 | 1 | 2 | 3 | 4 | 5 |
    /// ----------------------------------
    /// | char  || c | c | a | n | n | c |
    /// ----------------------------------
    /// | value || 1 | 1 | 3 | 4 | 5 | 5 |
    ///
    /// - Important: The Algorithm used to get the KMP swift table has running time O(n)
    public func kmpSwiftTable (forPattern pattern : String) -> [SwiftTableContent]
    {
        var table = initTable(withPattern: pattern)
        var i = 1, j=0 // i = 1 to move pointer one char forward.
        while (i+j<pattern.characters.count)
        {
            if table[i+j].char == table[j].char
            {
                // chars of i + j and j indexes are the same
                table[i+j].value = i
                j+=1
            }
            else {
                // Chars at i + j and j indexes are not the same
                if j==0 {
                    table[i].value = i + 1;
                }
                // checks for negative values
                if (j-1 < 0)
                {
                    j = 1
                }
                i = i + table[j-1].value
                j = j - table[j-1].value
            }
        }
        return table
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

