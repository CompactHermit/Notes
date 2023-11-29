#import "@preview/prooftrees:0.1.0": *
#import "colors.typ":*

#rect(fill: atomic-tangerine)[Awooga]
#for x in range(3) [
  Hi #x.
]

#for letter in "awoo ga" {
  if letter == " " {
    break
  }
  letter
}

$ f(x) $
#set text(14pt) // All text is 14 pixels now
Even though the size here is normal, we can #text(20pt)[set the context] to
increase size

#set enum(numbering: "1.1")

Good results can only be obtained by
+ following best practices
  + nest
  + second nest
+ being aware of current results of other researchers
+ checking the data for biases

