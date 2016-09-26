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
• Now that we got the KMP swift table from the pattern, we can start looking for ocurrences in the string 
```
    /// This method can be called from Self String to perform string matching using KMP string
    /// searching algorithm. If the pattern exist in the text, it will find the first ocurrence
    /// of the pattern.
    /// - Parameter pattern: Represents the pattern to be matched against the text
    /// - Important: Ocurrences are counted from 0...m-1 where m is the length of the text to be matched
    ///
    /// The following code sniped is an example of how to use this method
    ///     let result = "canccanccannca".matchWithKMP(forPattern: "ccannc")
    ///     if (result.matched)
    ///     {
    ///        print("First ocurrence found: ")
    ///        print("from index: \(result.fromIndex) to index \(result.toIndex)")
    ///     }
    ///     else
    ///     {
    ///        print("No ocurrences found")
    ///     }
    ///
    ///- Note: This method only match the first ocurrence found. Other ocurrences in the
    ///               same text after the first one won't be taken into account.
    ///- Returns:
    ///     - matched: true if the pattern was found on the text. Otherwise, returns false.
    ///     - fromIndex:    If matched, returns the first index of the first
    ///                     ocurrence found in the String. Otherwise, returns -1
    ///     - toIndex:      If matched, returns the last index of the first ocurrence
    ///                     found. Otherwise, returns -1
    ///- Process done by this method for every iteration of the outer loop
    ///  i = 0, j={0...1} -> i=1, j=0 -> matched first character c in text in index 0
    ///  i = 1, j={0} -> i=2, j=0 -> not matched character 
    ///  i = 2, j={0} -> i= 3, j= 0 -> not matched character
    ///  i = 3, j={0...4} -> i=7, j=0 -> matched characters ccan in text from index 3 to 6
    ///  i = 7, j={0....6} -> we found our first ocurrence from index 7 to 12 in string because j>=patternLength.
    
    public func matchWithKMP(forPattern pattern : String) ->(matched : Bool, fromIndex : Int, toIndex : Int)
    {
        
        let textLength = self.characters.count
        let patternLength = pattern.characters.count
        var toIndex = -1
        let st = kmpSwiftTable(forPattern: pattern) // swift table for this pattern
        var i = 0, j=0
        var tchar: Character
        while (i + j < textLength)
        {
            tchar = self[self.index(self.startIndex, offsetBy: i+j)] // char from text at i + j index
            
            // while the char at index i + j of the text is equal to the char at index j of pattern
            // then, increment j
            while ( tchar == st[j].char )
            {
                j+=1
                if (j>=patternLength) // First ocurrence of pattern found at index i of text
                {
                    toIndex = i + (patternLength - 1)
                    return (true, i, toIndex)
                }
                // pattern not found completely, then update char of text to the next char
                tchar = self[self.index(self.startIndex, offsetBy: i+j)]
            }
            if (j-1 <= 0) // check for negative values
            {
                i = i + 1
                j = 0
            }
            else
            {
                i = i + st[j-1].value // increment i
                j = j - st[j-1].value // decrement j
            }
        }
        return (false, -1, toIndex) // pattern not found.
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
   
   // matched = true, fromIndex = 0, toIndex = 0
   " ".matchWithKMP(forPattern: " ")
   
   // matched = false, fromIndex = -1, toIndex = -1
   "".matchWithKMP(forPattern: "") // note that matching "" against "" fails because it does not have any length.
   
   // Assigning matching results to properties (constants in this context)
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
<h1> Comming Soon </h1>
• So far, this extension only finds the first ocurrence of a pattern matched against a string with a average run time of O(n + m) which is very efficient compared to the standar string matching algorithm that has a run time of O(n^2) in the worst case. Now, I am working in a implementation to find all the ocurrences in the string using Knuth–Morris–Pratt algorithm  
