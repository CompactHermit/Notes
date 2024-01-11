#import "templates.typ": conf
#import "@preview/fletcher:0.4.3": *
// #import "@": items
#show: doc => conf(
  title: [Hermit Templates Ipsum Junk],
  authors: (
    (
      name: "Compact Hermitian",
      affiliation: "Some uni PhD Department, Not Doxing Myself",
      email: "compacthermitian@proton.me",
    ),
    (
      name: "Some Faggot on the internet",
      affiliation: "Somewhere in the far off galaxy",
      email: "Darth.Something@genghis.compacthermit.dev",
    ),
  ),
  abstract: lorem(80),
  doc,
)



#figure(
  image("../assets/HTT.png"),
  caption: ["Some HTT Kinda Shit"],
) <faker>
#figure(
  image("../assets/haskell.png"),
  caption: ["Some HTT Kinda Shit"],
) <infirm>
= Introduction
#lorem(300)
== Helper::
#lorem(40)

=== Helper::
#lorem(300)
==== Oops::
#lorem(400)
