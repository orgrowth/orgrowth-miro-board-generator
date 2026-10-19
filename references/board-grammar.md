# Board grammar: the frame unit, the moves, and the brand mapping

The board is read by two audiences at once: the person in the room and the viewer at home, at phone size, over the presenter's shoulder. Everything below exists to keep it legible for the second one.

## The eight colour roles

Every brand is mapped onto these roles once, in `brand/board-style.md`. Shapes and text on the board only ever name a role.

| Role | What it carries | How to pick it from a brand |
|---|---|---|
| Ground | Every frame fill | The brand's page background (light or dark; follow the website) |
| Surface | Cards, stat plates | The card or panel colour; on a light ground slightly brighter than ground, on a dark ground slightly lighter |
| Hairline | Card borders | The brand's divider or border colour; low contrast against surface. If the brand has none, derive one step from surface and say so in the file |
| Marker | Section labels, the one accent dot, arrows inside a frame | The brand's single strongest accent that passes contrast as text on ground |
| Plate, with plate ink | The claim line under every title, the CTA | The brand's button colour; the ink is whatever the brand prints on that button |
| Body ink | Card text, small labels | The brand's body text colour |
| Heading ink | Frame titles, stat figures | The brand's heading colour (often a darker or brighter step of body ink) |
| Three section bands | A tinted band behind the content of each frame kind: problem, work, proof | Three low saturation tints of the brand palette; if the brand has one accent, use three opacities of it over ground |

A brand accent that fails contrast as text (a gold, a pale yellow, a neon on white) is a plate colour, never an ink: it carries a block with dark ink on it and never carries a word on the ground.

Fonts: Miro offers a fixed list (the composer spec names it). Map the brand's heading face, body face and label face to the nearest in feel: a geometric or grotesk sans to a clean sans, a condensed display face to a condensed sans, a monospace label face to a monospace, a serif to a serif. Record which real face each stands in for, so the owner understands why the board is not pixel identical to their website.

## The frame unit

Frames are 2000 by 1500, laid left to right with a 300 gap, so the viewer and the camera move one way. Inside a frame, nothing closer than 80 px to any edge.

1. **Section label**, top left: `01 / KICKER` in the marker colour, the label font, 24. Tells the viewer where they are.
2. **Title**, heading ink, 64, one line, two at most.
3. **Claim line**, on a plate in the plate colour with plate ink, 30, full content width. One sentence stated to the audience. Never an instruction to the presenter. When the owner will say the claim live instead, the plate is a dashed empty box in the ground colour, same size, same place.
4. **Section band**, the band for this frame's kind, behind the content, created before the content.
5. **Content**: cards for facts (32 to 36, two lines at most, one idea each), stat plates (figure 72 to 120, label 24), dashed empty boxes in the ground colour for anything filled live, images for proof. Two to four images per frame, each beside the card it proves.
6. **Arrows** in the gaps between frames, in the plate colour. Connectors cannot end on a frame, so the arrow is a shape.

Nothing else. No questions, no takeaway notes, no cues. The presenter's script is the run sheet, not the board.

## The moves a reference board usually shows

Reduce every reference to moves like these before building. Name the move and the timestamp where it shows; the content of the reference stays in the reference.

| Move | What it is |
|---|---|
| Numbered section label | A small chip above each section telling the viewer where they are |
| Claim line | One highlighted sentence stating the section's point |
| Card row | Three to five cards under the claim; the content |
| Proof beside claim | A real screenshot dropped next to the card it supports, often with a bold one word tag above it |
| Stage arrows | Arrows joining stages of a process, left to right |
| Live fill | An empty box the presenter writes in on camera |
| Camera inset | Where the presenter's camera sits over the board (a corner), which decides which corner of each frame stays quiet |
| Playback | The subject's own content shown full screen and discussed; a cue for the edit, not an item on the board |
| Reading direction | Left to right, top to bottom, never broken by a frame that reads upward |

## Frame kinds and their bands

| Kind | Typical frames | Band |
|---|---|---|
| Opener and results | Title frame, the headline result, the before and after | Proof band |
| Problem and opportunity | What was broken, what was possible | Problem band |
| What was done | The steps, the system, the offer, the process | Work band |
| Close | What the viewer does next, the CTA | Proof band with the plate carrying the CTA |

A six to twelve frame board usually runs: opener, headline result, where it started, the problem, the opportunity, three to five step frames, what happened, the service or product version of the same thing, the close.

## Template for `brand/board-style.md`

```
# Board style

Source: <ds-bundle path, brand/design.md, guidelines file, or website URL> (read YYYY-MM-DD)

## Colour roles
| Role | Hex | Stands in for |
|---|---|---|
| Ground | #...... | <token or page background> |
| Surface | #...... | |
| Hairline | #...... | |
| Marker | #...... | |
| Plate | #...... | |
| Plate ink | #...... | |
| Body ink | #...... | |
| Heading ink | #...... | |
| Problem band | #...... | |
| Work band | #...... | |
| Proof band | #...... | |

## Fonts
| Role | Miro font | Stands in for |
|---|---|---|
| Headings | | |
| Body | | |
| Labels | | |

## Floors
Section label 24, title 64, claim 30, cards 32 to 36 (two lines), stat figure 72 to 120, labels 24. Nothing under 24. 80 px clear from every frame edge. Frames 2000 by 1500, gap 300.

## Camera
Inset corner: <bottom left | bottom right | top right>. Keep that corner of every frame free of cards.

## Corrections
(one dated line per correction the owner makes, newest last)
```
