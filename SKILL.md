---
name: orgrowth-miro-board-generator
description: Build the Miro board you walk through on camera for a YouTube video, strategy breakdown, case study or whiteboard session, in your own brand colours and fonts, structured after the reference videos you point it at. Connects and confirms the Miro MCP, takes your design bundle or brand guidelines, gathers everything about the video, downloads the reference videos and lays their frames out to copy the board structure, locks a frame by frame run sheet with you, then builds the board through the Miro MCP and verifies it. Trigger on "miro board for my video", "build the board", "whiteboard board", "walkthrough board", "board like this video", or /orgrowth-miro-board-generator. Not for editing the footage afterwards.
metadata:
  requires:
    bins: ["yt-dlp", "ffmpeg"]
    mcp: ["miro"]
---

# Miro Board Generator

## Purpose

The board is the thing on screen for most of the video, so it carries the argument on its own: big statements, real numbers, a screenshot beside every claim, in the owner's brand. The run sheet is the owner's script and is approved before a single item lands on the board.

**The order is fixed: Miro connected, design in, context in, references studied, run sheet approved, assets gathered, board built, board verified.** Building before the run sheet is approved means a rebuild, and a rebuild on the day of a shoot is how boards ship wrong.

## Inputs

- **Miro.** The Miro MCP connected and signed in to the team that will hold the board (Preflight 1).
- **The look.** One of, in this order of preference: a `ds-bundle/` folder in the workspace (`tokens.css`, `tokens.json`, `README.md`, exported from the owner's own website or design system); `brand/design.md`; a brand guidelines file (PDF, document, image); a website URL; or two colours and a font feel typed in chat. The first run writes `brand/board-style.md` (the brand mapped onto the board grammar) and every later run reads it first.
- **The video.** Everything the owner can give about it: the one paragraph argument, who it is for, the story beats, the numbers and where each comes from, screenshots of results or dashboards, a script or outline if one exists, the call to action, and what will be filled in live on camera.
- **Reference videos.** One to three YouTube URLs of board walkthroughs whose structure the owner likes (the same creator's videos work best), or a description of the structure in their own words when there is no reference.
- `brand/` when it exists: `brand.json` (name, spelling), `voice.md` (how the board text sounds), `offer.md` (the CTA and the Do-not-say list), `proof.md` (the only numbers citable without a source in the message), `audience.md`.

## Preflight (every run)

1. **Miro MCP.** Look for tools prefixed `miro` (the canvas tools are `canvas_get_canvas_composer_skill`, `canvas_create_from_svg`, `canvas_update_from_svg`, `canvas_read_as_svg`, `canvas_search`, plus `board_create`, `board_search_boards`, `image_get_upload_url`, `image_create`). If none are listed, give the owner this in a code block and wait:

   ```
   claude plugin install miro@claude-plugins-official
   ```

   Manual alternative, same result: `claude mcp add --transport http miro https://mcp.miro.com/`. Then they restart Claude Code, type `/mcp`, choose Miro, and sign in, picking the Miro team that will hold the board (the connection is team specific). **Confirm it yourself before moving on:** call `board_search_boards` and tell the owner which team and how many boards it sees. A tool list that still shows `layout_*` or `board_list_items` tools is stale: the owner disconnects and reconnects Miro in `/mcp`. Works on every Miro plan, including free.
2. **Composer spec.** Call `canvas_get_canvas_composer_skill` once now and keep its answer; it is the authoritative SVG format for everything written to the board. Read `references/miro-canvas-notes.md` beside it; where the two disagree, the spec wins and the notes get corrected.
3. **Tools for references.** `yt-dlp -h` and `ffmpeg -version` answer. If not: `brew install yt-dlp ffmpeg` on a Mac, `pip install -U yt-dlp` plus the package manager's ffmpeg elsewhere. Without them the reference step works from screenshots the owner pastes.
4. **Workspace.** Read everything in `brand/` that exists, `brand/board-style.md` first. If `brand/` is missing, carry on with what the owner gives in chat; this skill never writes voice, audience, offer or proof files.
5. **Output folder.** `boards/YYYY-MM-DD-<slug>/` for this board (slug from the video title, three to six words). Everything this run makes lives there.

## Steps

### 1. The look: write or read `brand/board-style.md`

If `brand/board-style.md` exists, read it and go to Step 2. Otherwise:

1. Ask for the design source and the camera in one question: "Do you have a `ds-bundle/` folder or brand guidelines (PDF, doc, image), or should I read your website? If none of those, give me two colours and a font you like. And which corner of the screen will your camera sit in while you present?" Read what arrives: `ds-bundle/tokens.css` and `README.md` first, then `brand/design.md`, then a guidelines file with the Read tool, then the website with your web fetch tool.
2. Map it onto the eight board roles in `references/board-grammar.md` (ground, surface, hairline, marker, plate and its ink, body ink, heading ink, three section bands). Pick the nearest font Miro offers for headings, body and labels from the list in the composer spec, and say which real face each stands in for.
3. Show the mapping in chat as a table with a swatch column (hex) and get a yes. Then write `brand/board-style.md` from the template at the end of `references/board-grammar.md`, including the type floors and a dated "Corrections" section that starts empty.

Every board uses this file. One kit per brand; never mix a second palette in because a guest or a client is the subject.

### 2. The video: gather everything

One message asking for everything at once, then targeted follow ups for the gaps, one at a time:

"Tell me everything about this video. Paste or drop in: the argument in a paragraph, who it is for, the story in order, every number you want on screen and where it comes from, any screenshots of results or dashboards, the script or outline if there is one, the call to action, anything you will fill in live on camera, and one to three YouTube links of board walkthroughs whose structure you want this board to follow (the same creator's videos work best). I only copy their layout and pacing, never their content."

Then sort what arrived:

- **Numbers.** Each one goes in a table: figure, what it measures, source (a file, a screenshot, `brand/proof.md`, or "owner stated, no source"). A number with no source is flagged, never dropped silently, and goes on the board only if the owner confirms it. Never derive a number the owner did not give (no "that is 3x", no "about 40%"); if a derived figure would help, propose it in the table marked derived and let them say yes.
- **Live fills.** Anything the owner will write or say on camera becomes a dashed empty box on the board, never pre filled. That includes a frame's claim line when the owner wants to deliver it live: a dashed plate in the ground colour where the claim would sit, named as a live fill in the run sheet.
- **References.** If no YouTube link arrived, ask once as its own follow up: "Is there a video whose board structure you want this one to follow? Paste one to three YouTube links, or describe the structure in your own words." Only when the owner says they have none, use the default grammar in Step 3 and say so. Never pick a reference video for them.
- **Argument.** If they did not give the one paragraph, draft it from what they gave and put it at the top of the run sheet for correction.
- **Claims and steps.** Every card on the board states something the owner said in this step or that is in `brand/`: the steps they took, the problems they saw, the titles they used, the searches they found. Nothing on a card is drafted to fill a slot. When a frame the structure needs has no owner material (the five titles, the before state, what the audience searches), the card slot becomes a question in the run sheet, or a dashed live fill if the owner prefers to say it on camera. A board with an honest gap beats a board with a plausible invention; the invention is what the owner's audience will catch.

### 3. The references: copy the structure, not the content

For each reference URL, from the workspace root:

```
bash <skill>/scripts/reference-frames.sh sheet "<url>" boards/<folder>/references/<videoId> 60
```

It downloads the video once at 480p and writes `contact-sheet.jpg` (one tile a minute, six per row) and `legend.txt` (tile number to timestamp). Read the sheet with the Read tool, find the tiles where the board fills the screen, then pull exact frames:

```
bash <skill>/scripts/reference-frames.sh grab boards/<folder>/references/<videoId> 1450 1510 2380
```

Read every grabbed frame. When the board is a screen inside the shot (a TV behind the presenters, a laptop), crop to it before reading: `ffmpeg -y -i frames/frame-1450s.jpg -vf "crop=w:h:x:y" frames/frame-1450s-board.jpg`, with the box measured off the full frame. When the owner wants the reference's frameworks as well as its look, pull its captions into the same folder with `yt-dlp --write-auto-subs --sub-langs "en.*" --skip-download -o "boards/<folder>/references/<videoId>/captions" "<url>"`; their timestamps line up with the frames.

Write `boards/<folder>/structure-map.md`: for each reference, the structural moves you can see (numbered section label, one line claim, row of cards, proof screenshot beside a claim, arrows between stages, empty box filled live, camera inset position, reading direction), how many sections the board has, how dense each is, and which two or three moves this board will take. Name moves, not topics: the reference is a template for layout and pacing, never a source of numbers, claims or images for the owner's board. Nothing from another creator's video goes on the owner's board.

No reference? Use the default grammar in `references/board-grammar.md` and whatever structure the owner described, and say so in the structure map.

### 4. The run sheet, then STOP for approval

Show the frame list in chat before writing any file: one block per frame, in board order, each with a title, the claim line the audience reads, the cards (one idea each, their exact text), the numbers with their sources, the images that will sit beside the claims, and the live fills. Keep it to what the reference pacing supports (most boards are six to twelve frames; three to five cards a frame, two to four images a frame).

**Stop here.** The owner reorders, renames, merges, adds an opener, drops frames. Do not call a single Miro write tool until they say the structure is right, even if they say "just build it": answer that the list above is the board and one yes on it saves a rebuild. On the yes, write `boards/<folder>/run-sheet.md` with the approved frames, plus a "Numbers to be careful with" section (every flagged or derived figure with its status) and "Open items" (what the owner still has to supply or decide).

If changes arrive after the board exists, edit the board with `canvas_update_from_svg` item by item. Never wipe and rebuild.

### 5. Assets

Gather into `boards/<folder>/assets/`: the owner's screenshots (results, dashboards, posts, pages), their logo or marks (from the bundle, or fetched from their website's icon and social image links), and any product or cover images the run sheet names. Read every image before placing it; a screenshot that shows a different figure from the one on the card beside it is the first thing a viewer notices. If an image the run sheet needs is missing, ask for it now, one at a time, or mark that slot as a live fill with the owner's agreement.

Upload each image through the Miro MCP (`image_get_upload_url`, upload the file to the returned URL, then `image_create` with the token it gives you, parented to its frame) once the frame exists in Step 6.

### 6. Build

1. **Board.** `board_create` named after the video, fresh every time, unless the owner gave a board URL to build into. Record the URL in `boards/<folder>/board-url.txt`.
2. **Frames, one `canvas_create_from_svg` call per frame,** left to right, following the composer spec. A frame is a group holding a frame rectangle (its title set with the attribute the spec names) and its children, positioned inside the frame's box. The unit for every frame, from `references/board-grammar.md`: section label top left in the marker colour, title in heading ink, a claim line on a plate in the plate colour with its ink, a section band in the band colour for that frame's kind, then the content (cards, stat plates, dashed live boxes, images), with arrows in the gaps between frames. Create the band before the cards and every plate before the text on it; z order is creation order.
3. **Type floors.** Section label 24, title 64, claim line 30, cards 32 to 36 with two lines at most, stat figures 72 to 120, small labels 24. Nothing under 24 anywhere; nothing closer than 80 px to a frame edge. One idea per card. Big statement, small support. No source captions on the board (sources live in the run sheet).
4. **Save what you sent.** Append every SVG you send, and the result the tool returns (it carries the item ids), to `boards/<folder>/board.svg.log`. Updates are made from those ids.
5. **Never on the board:** a question, a director note, a prompt to the owner, a timing cue, a claim or step the owner did not give you, a number with no source, a number that differs from the screenshot beside it, an em dash, an en dash, a double hyphen, or a percentage spelled out (`79%`, never `79 percent`). The owner is screen sharing; the audience reads everything.

### 7. Verify

Read each frame back with `canvas_read_as_svg` scoped to that frame (a frame scoped read is cheap, a whole board read is not). For every frame check: the title matches the run sheet, the item count matches what you sent, every number equals the run sheet figure and the screenshot beside it, no item's rendered bounds cross the frame edge, every image rendered (a failed upload leaves a gap, not an error), and the smallest font is 24 or more. Fix each miss with `canvas_update_from_svg`; re read that frame after fixing. Open the board link yourself if a browser tool is available and look at the first and last frame; if none is, the per frame read back is the proof, and say so.

## Output

```
boards/YYYY-MM-DD-<slug>/
  run-sheet.md        the approved frames, numbers to be careful with, open items
  structure-map.md    what the references do and which moves this board took
  references/<id>/    source.mp4, contact-sheet.jpg, legend.txt, frames/
  assets/             every image placed on the board
  board.svg.log       every SVG sent and every result returned
  board-url.txt
brand/board-style.md  written on the first run; corrections appended on every run
```

Hand over in this shape: the board link; the run sheet path; the flagged numbers in one block; the open items (images the owner still has to drop in, live fills, the CTA keyword if one is used); and one line on what was verified and what was not. When the owner corrects anything about the look or the layout during the run, fix it and append the rule behind the fix to `brand/board-style.md` as one dated line, so the next board starts right.

## QA checklist

- [ ] Miro MCP confirmed by a real call before anything else, and the composer spec fetched this session
- [ ] `brand/board-style.md` exists, was read, and every colour and font on the board comes from it
- [ ] Every number on the board is in the run sheet table with a source, and matches the screenshot beside it
- [ ] Every card traces to something the owner said or a file in `brand/`; no step, search, title or story beat was drafted to fill a slot
- [ ] Nothing from a reference video is on the board; references shaped the layout only
- [ ] The run sheet was approved in chat before the first Miro write
- [ ] No question, director note, timing cue or source caption on the board
- [ ] No font under 24, no item within 80 px of a frame edge, no em or en dash, no double hyphen, `%` symbol for every percentage
- [ ] Every frame read back and its item count, title and numbers checked; what could not be verified is named in the hand over
- [ ] Corrections from this run appended to `brand/board-style.md`

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| No `miro` tools after installing | Claude Code not restarted, or not signed in | Restart, `/mcp`, choose Miro, sign in, pick the team |
| Tools listed are `layout_*` or `board_list_items` | Stale tool list from an older server version | Disconnect and reconnect Miro in `/mcp`; refreshing is not enough |
| Board created in the wrong team | The sign in picked another team | Reconnect and choose the team that owns the board; the connection is per team |
| A 1 px border vanished, or labels will not left align | The canvas tools accept borders above 1 px and centre every label | Use `stroke-width` 2 or more, or the fill colour as the stroke; design cards for centred text |
| An item will not move into another frame on update | Re parenting through an update is rejected or silently ignored | Delete it and recreate it inside the right frame group |
| An item an owner made by hand will not update | Some UI made items are read only to the API | Recreate beside it and ask the owner to delete the original |
| `yt-dlp` says sign in to confirm you are not a bot | YouTube bot wall | The script retries with the android client; else set `YTDLP_COOKIES_BROWSER=chrome` in the environment, or `brew upgrade yt-dlp` |
| Frames grabbed show the wrong shot | A seek placed before the input snaps to a keyframe | Use the script; it seeks after opening the input |
| Whole board read is slow or truncated | Reads past a few hundred items are expensive | Read one frame at a time, scoped to the frame |
| A frame came back with a different title | Miro renamed it on create | Fix the title with `canvas_update_from_svg` using the frame's id |
