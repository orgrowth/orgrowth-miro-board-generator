# Miro MCP canvas tools: what to expect

The official Miro MCP server (`https://mcp.miro.com/`, installed in Claude Code as the `miro` plugin) writes boards from SVG. The spec returned by `canvas_get_canvas_composer_skill` is the authority; call it once per session before writing, and if anything here disagrees with it, follow the spec and fix this file.

## Tools you use

| Tool | Use |
|---|---|
| `board_search_boards` | The connection check; it also finds a board the owner names |
| `board_create` | A fresh board per video |
| `canvas_get_canvas_composer_skill` | The SVG format spec; once per session |
| `canvas_load_format_skill` | Extra guidance for a named format (diagramming); not needed for walkthrough boards |
| `canvas_create_from_svg` | Creates many items in one call; one call per frame keeps a failure scoped |
| `canvas_read_as_svg` | Reads items back; scope it to a frame with the board URL plus `?moveToWidget=<frame-id>` |
| `canvas_update_from_svg` | Applies an SVG as a diff: create, update, delete by id |
| `canvas_search` | Finds items by text before reading a big board |
| `image_get_upload_url`, `image_create` | Upload a local image, then place it, parented to a frame |

The older `layout_*`, `board_list_items`, `diagram_*` and `doc_*` tools were removed in September 2026; a client still listing them has a stale tool cache and needs a full disconnect and reconnect.

## Shape of the SVG (as seen in Miro's own issue tracker; the spec wins)

- A frame is a group containing a rectangle marked as a frame (`data-type="frame"`) with a title attribute (`data-title`), and its children nested inside that group with coordinates inside the frame's box.
- Items carry a type hint (`data-type`, for example `sticky`), their label in `data-content`, and font size in `data-font-size`. Fill and stroke are plain SVG `fill`, `stroke`, `stroke-width`.
- Every created item comes back with a stable `data-miro-id`; updates and deletes reference that id. Keep the returned SVG; it is the id map.
- Items read back carry `data-rendered-bounds="x y width height"`, which is what Miro actually drew. Check edges against that, not against your own arithmetic.
- Creation order is z order. Band before cards, plate before the text on it, image after the card it sits beside.

## Known limits (verified against Miro's issue tracker, September 2026)

| Limit | Consequence | Do this |
|---|---|---|
| `stroke-width` must be above 1; a 1 px border is dropped | Borderless looking cards lose their hairline | Use 2, or set the stroke to the fill colour for a borderless card |
| Shape labels are centred horizontally and vertically; there is no alignment attribute | A top left card layout cannot be reproduced | Design cards for centred text: short lines, one idea, generous padding |
| Re parenting an item through `canvas_update_from_svg` is rejected ("target parent is not the actual parent") or silently ignored | An item cannot be moved between frames by editing | Delete and recreate it inside the right frame group |
| A whole board read past a few hundred items is slow and may truncate | Verification by whole board read is unreliable | Read one frame at a time |
| Some items made by hand in the Miro UI are read only to the API | They cannot be moved, edited or deleted | Create the replacement beside or over it (later items sit on top) and ask the owner to delete the original |
| Connectors cannot end on a frame | An arrow between frames fails | Draw an arrow shape in the gap |
| Deletion through the canvas tools is consent gated | A wipe needs the owner's yes each time | Never wipe; update by id. Board history can recover a mistake |

## Fonts

Miro renders from its own font list, not from the brand's web fonts. The composer spec lists what is accepted; map each brand face to the nearest and record the mapping in `brand/board-style.md`.
