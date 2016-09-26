# Knuth–Morris–Pratt string searching algorithm (or KMP algorithm) with Swift

<h1> Description </h1>
• Knuth–Morris–Pratt algorithm is an efficient string search algoritm with running time O(n + m)
• This project implements the KMP in Swift using a String extension class. So, using the KMP.swift
  class, a given pattern can be matched in a string finding its first ocurrence on the text. 

<h1> Installation </h1>
• Copy and paste KMP.swift file into your project directory.

<h1> Examples </h1>
- These are some examples implementing the KMP String extension.
• "this is a string to be matched".matchWithKMP(forPattern: "g to") // matched = true, fromIndex = 15, toIndex = 18
• "🚕🚕🚖🚖🚀🚏🚤🚅🚅🚅🚝🚤🚔".matchWithKMP(forPattern: "🚅🚅🚅") // mathed = true, fromIndex = 7, toIndex = 2
• "this is a string to be matched".matchWithKMP(forPattern: "astring") // matched = false, fromIndex = -1, toIndex = -1



