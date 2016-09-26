///
/// Author:       Jose Ortiz <jose@jortizsd.com>
/// File:         KMP.swift
/// Date:         September 25, 2016
/// Description:  String extension to Knuth–Morris–Pratt string searching algorithm
///

import Foundation

extension String {
    
    /// This method can be called from Self String to perform string matching using KMP string
    /// searching algorithm. If the pattern exist in the text, it will find the first ocurrence
    /// of the pattern.
    /// - Parameter pattern: Represents the pattern to be matched against the text
    /// - Important: Ocurrences are counted from 0...m-1 where m is the length of the text to be matched
    ///
    /// The following code sniped is an example of how to use this method
    ///     let result = "thisisjustanexample".matchWithKMP(forPattern: "isis")
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
    
    /// Initializes a KMP swift table
    /// - Parameter pattern: the string pattern to be matched
    /// - Returns: A list of SwiftTableContent structs representing a KMP swift table
    ///           which values initilized to 0
    /// - Note:
    ///  For the pattern "ccannc" this method will return a list of structs representing
    ///  the following table. Index 0 has value 1 because chars at index i and j
    ///  represent the same character.
    ///
    /// ----------------------------------
    /// | index || 0 | 1 | 2 | 3 | 4 | 5 |
    /// ----------------------------------
    /// | char  || c | c | a | n | n | c |
    /// ----------------------------------
    /// | value || 1 | 0 | 0 | 0 | 0 | 0 |
    /// ----------------------------------
    ///
    ///
    ///
    func initTable (withPattern pattern : String) -> [SwiftTableContent]
    {
        var table = [SwiftTableContent]()
        var p_char: Character?
        if (pattern != "") // make sure pattern is not empty string.
        {
            table.append(SwiftTableContent(index: 0, char: pattern.characters.first, value: 1))
            for k in 1..<pattern.characters.count
            {
                p_char = pattern[pattern.index(pattern.startIndex, offsetBy: k)]
                table.append(SwiftTableContent(index: k, char: p_char, value: 0))
                
            }
        }
        return table
    }
    
    /// Struct representing a column of a KMP Swift table
    public struct SwiftTableContent 
    {
        var index: Int;
        var char: Character?;
        var value: Int;
    }
}


