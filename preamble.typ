#let template(
  body,
  title: [Labb],
  logo: none,
) = {
  set page(
    paper: "a4",
    margin: (x: 22mm, top: 22mm, bottom: 20mm),
  )
  show heading.where(depth: 1): set text(
    font: "Exo",
    weight: 700,
    size: 23pt,
  )

  show heading.where(depth: 2): set heading(numbering: (..) => h(-.3em))
  show heading.where(depth: 2): set text(font: ("Open Sans", "Liberation Sans"), weight: 700, size: 14pt)

  show heading.where(depth: 3): set text(font: ("Open Sans", "Liberation Sans"), weight: 700, size: 11pt)
  show heading.where(depth: 3): set heading(numbering: (.., level, last) => str(level) + "." + str(last))

  set text(font: ("Open Sans", "Liberation Sans"), size: 10.5pt, weight: 300)

  show raw.where(block: true): it => box(fill: color.luma(95%), inset: 10pt, radius: 5pt, it)

  box(
    stroke: 3pt + color.rgb("#ffc600"),
    inset: 10pt,
    outset: (x: 30pt),
    radius: 10pt,
    fill: color.rgb("#02005b"),
    table(
      columns: (1fr, auto),
      stroke: none,
      align(heading(depth: 1, text(fill: white, title)), horizon), image(logo, height: 5em),
    ),
  )
  v(1em)
  body
}
