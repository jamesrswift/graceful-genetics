#let make-venue = {
  box(width: 100%, height: 2.5cm, inset: 10pt)[
    #set text(font: "Arial", weight: "bold")
    #grid(
      columns: (1fr, auto),
      rows: (auto, auto),
      gutter: 5pt,
    )
  ]
}

#let template(
  title: [],
  authors: (),
  date: [],
  doi: "",
  keywords: (),
  abstract: [],
  body,
) = {
  
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 1in, x: 1.6cm),
  )
  set text(10pt, font: "Arial")
  set list(indent: 8pt)
  show heading: set text(size: 11pt)
  show heading.where(level: 1): set text(font: "Arial", weight: "bold", fill: rgb("#333333"), size: 18pt)
  show heading: set block(below: 8pt)
  show heading.where(level: 1): set block(below: 12pt)
  
  place(top, dy: -2.5cm, make-venue)
  v(20pt)
  
  text(14pt, weight: "medium", fill: rgb("#666666"), "Review")
  v(4pt)
  strong(text(20pt, font: "Arial", weight: "bold", fill: black, title))
  v(12pt)
  
  text(10pt, font: "Arial",
    authors.enumerate().map(((i, author)) => author.name + [ ] + super[#(i+1)]).join(", "))
  v(8pt)
  
  for (i, author) in authors.enumerate() [
    #set text(8pt)
    #super[#(i+1)]
    #author.institution
    #link("mailto:" + author.mail) \
  ]
  v(12pt)
  
  set text(9pt)
  set par(justify: true)
  
  block(width: 100%, inset: 10pt, fill: rgb("#e6f3f7"), radius: 4pt)[
    #text(font: "Arial", weight: "regular", abstract)
    #v(8pt)
    #box(width: 100%, inset: (x: 0pt, y: 4pt), stroke: (y: 0.5pt + rgb("#0096d6")))[
      #strong[Highlights]
    ]
    // Add highlight points here
  ]
  
  v(18pt)
  show figure: align.with(center)
  show figure: set text(8pt)
  show figure.caption: pad.with(x: 10%)
  columns(2, body)
}