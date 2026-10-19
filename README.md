# Miro board generator

A Claude Code skill that builds the Miro board you walk through on camera for a YouTube video, strategy breakdown, case study or whiteboard session. It works in your own brand colours and fonts, copies the structure (never the content) of the board walkthroughs you point it at, and writes the whole board through the official Miro MCP.

You supply every claim and every number. The skill never invents a step, a stat or a story beat to fill a slot; a gap becomes a question for you or a dashed box you fill live on camera.

## What it does

1. Connects to the official Miro MCP and confirms it with a real call before anything else.
2. Reads your look: a design token bundle, brand guidelines, your website, or two colours and a font. The first run writes `brand/board-style.md`, and every later board reads it.
3. Asks for everything about the video in one go: the argument, the story, the numbers and where each comes from, your screenshots, the call to action, and one to three reference walkthrough videos.
4. Downloads the reference videos, lays their frames out on a contact sheet and maps their structure: section labels, claim lines, card rows, proof screenshots, arrows, live fills, camera corner.
5. Shows you a frame by frame run sheet and stops until you approve it.
6. Builds the board one frame at a time from SVG, with your screenshots uploaded beside the claims they prove.
7. Reads every frame back and checks titles, item counts, numbers, image uploads, frame edges and the 24 point type floor.

## Requirements

- [Claude Code](https://claude.com/product/claude-code)
- The official Miro MCP: `claude plugin install miro@claude-plugins-official`, then restart Claude Code, type `/mcp`, choose Miro and sign in to the team that will hold the board. Works on every Miro plan, including free.
- `yt-dlp` and `ffmpeg` for studying reference videos (`brew install yt-dlp ffmpeg` on a Mac). Without them the skill works from screenshots you paste.

## Install

```bash
git clone https://github.com/orgrowth/orgrowth-miro-board-generator ~/.claude/skills/orgrowth-miro-board-generator
```

## Use

Start a new Claude Code session in the folder you keep your content in and say "build a Miro board for my video", or type `/orgrowth-miro-board-generator`. Everything for each board is saved to `boards/YYYY-MM-DD-<slug>/`: the approved run sheet, the structure map, reference frames, assets, a log of every SVG sent to Miro, and the board link.

## What's in here

| Path | What it is |
|---|---|
| `SKILL.md` | The skill: preflight, the seven steps, the QA checklist and troubleshooting |
| `references/board-grammar.md` | The board grammar: the eight colour roles, the frame unit, the moves to look for in a reference, frame kinds, and the `board-style.md` template with its type floors |
| `references/miro-canvas-notes.md` | What the Miro canvas tools accept, and the known limits with workarounds |
| `scripts/reference-frames.sh` | Downloads a reference video once, builds a contact sheet, and grabs exact frames |

## Licence

MIT. Made by [Orgrowth](https://orgrowth.ai).
