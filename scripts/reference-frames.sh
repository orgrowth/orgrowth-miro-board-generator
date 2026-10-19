#!/usr/bin/env bash
# Pull a reference YouTube video at low resolution and lay its frames out so the agent
# can SEE how the board in it is built. Two modes:
#
#   bash reference-frames.sh sheet <youtube-url> <out-dir> [seconds-between-tiles]
#       downloads the video at 480p (once), writes contact-sheet.jpg (6 tiles per row, one
#       tile every N seconds, default 60) and a legend.txt that maps tile number to timestamp.
#
#   bash reference-frames.sh grab <out-dir> <seconds> [<seconds> ...]
#       writes one full-size frame per timestamp into <out-dir>/frames/ as frame-<seconds>s.jpg,
#       seeking AFTER the input is opened so the frame is exact (a seek before -i snaps to the
#       nearest keyframe and lands on the wrong shot).
#
# Needs yt-dlp and ffmpeg on PATH. Set YTDLP_COOKIES_BROWSER=chrome (or safari, firefox) in the
# environment if YouTube answers with a bot wall; the script passes it through.
set -euo pipefail

mode="${1:-}"
case "$mode" in
  sheet)
    url="${2:?youtube url}"; out="${3:?out dir}"; every="${4:-60}"
    mkdir -p "$out"
    src="$out/source.mp4"
    if [ ! -s "$src" ]; then
      args=(-f "bv*[height<=480]+ba/b[height<=480]/b" --merge-output-format mp4 --no-playlist
            --write-info-json -o "$out/source.%(ext)s" "$url")
      if [ -n "${YTDLP_COOKIES_BROWSER:-}" ]; then args=(--cookies-from-browser "$YTDLP_COOKIES_BROWSER" "${args[@]}"); fi
      if ! yt-dlp "${args[@]}"; then
        echo "retrying with the android player client" >&2
        yt-dlp --extractor-args "youtube:player_client=android,web" "${args[@]}"
      fi
      # yt-dlp may leave a .mkv or .webm when a merge is not possible; normalise the name
      for f in "$out"/source.*; do
        case "$f" in *.mp4|*.json) ;; *) ffmpeg -y -loglevel error -i "$f" -c copy "$src" && rm -f "$f" ;; esac
      done
    fi
    dur=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$src" | cut -d. -f1)
    n=$(( dur / every + 1 )); rows=$(( (n + 5) / 6 ))
    # tile needs an explicit grid; 6 columns by however many rows the tile count fills
    ffmpeg -y -loglevel error -i "$src" -vf "fps=1/${every},scale=320:-1,tile=6x${rows}" -frames:v 1 -q:v 3 "$out/contact-sheet.jpg"
    {
      echo "source: $url"
      echo "duration: ${dur}s   one tile every ${every}s   6 tiles per row, left to right, top to bottom"
      for i in $(seq 0 $((n-1))); do
        s=$(( i * every )); printf "tile %3d  row %2d col %d  t=%5ds  %02d:%02d\n" "$((i+1))" "$((i/6+1))" "$((i%6+1))" "$s" "$((s/60))" "$((s%60))"
      done
    } > "$out/legend.txt"
    echo "wrote $out/contact-sheet.jpg and $out/legend.txt (${dur}s of video, ${n} tiles in ${rows} rows)"
    ;;
  grab)
    out="${2:?out dir}"; shift 2
    src="$out/source.mp4"; [ -s "$src" ] || { echo "no $src; run sheet first" >&2; exit 1; }
    mkdir -p "$out/frames"
    for t in "$@"; do
      ffmpeg -y -loglevel error -i "$src" -ss "$t" -frames:v 1 -q:v 2 "$out/frames/frame-${t}s.jpg"
      echo "wrote $out/frames/frame-${t}s.jpg"
    done
    ;;
  *)
    sed -n '2,16p' "$0"; exit 1 ;;
esac
