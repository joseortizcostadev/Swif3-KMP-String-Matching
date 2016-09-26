import UIKit

/// Some test with KMP String extension file in playground
/// Results in playground can be interpreted as (matched: bool, fromIndex: Int, toIndex: Int)
/// See KMP.swift documentation to use the KMP String extension in your own projects

/* Note that all the operations made with KMP has run time O(n + m) wich is very efficient compared
   to standard string matching which has is O(n^2) */

"this is a string to be matched".matchWithKMP(forPattern: "g to") // matched

"this is a string to be matched".matchWithKMP(forPattern: " ") // matched for white character

"".matchWithKMP(forPattern: "") // not matched because empty string was provided

"this is a string to be matched".matchWithKMP(forPattern: "astring") // pattern not found


// Another exemple of matching with KMP.
var ocurrences = "this is a string to be matched".matchWithKMP(forPattern: "string")

if (ocurrences.matched)
{
   print("Matched from index: \(ocurrences.fromIndex) to index: \(ocurrences.toIndex)")
}









