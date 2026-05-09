# Middle English Historical Figures Directory · 中世纪英国历史人物目录

A static directory of personages from the Middle English literary world and its
monarchical/ecclesiastical surround — Chaucer, Langland, Gower, Manning, Margery
Kempe, Julian of Norwich, the Pearl Poet, Malory, Caxton, plus the
Plantagenet–Tudor monarchs that frame their world (Henry II → Henry VIII).

Single-file HTML, no build step. Same visual language as the sister project
`cf-deploy/` (Berkeley blue + gold, EB Garamond, parchment background).

## Live

- Production: deployed via Cloudflare Pages (auto-build on `main`).

## Edit

Just edit `index.html` — no build pipeline. The page lets you edit fields
inline; local edits are stored in `localStorage` per browser. To commit them
into the seed, paste the rendered values back into the `FIGURES_SEED` array
inside `index.html` and push to `main`.

To swap in real portraits: drop the JPG/PNG into `photos/` and put the file
name (e.g. `chaucer.jpg`) into the figure's `photo` field through the small
hover-to-edit overlay on the portrait — or hand-edit the `FIGURES_SEED` entry.

## Deploy

Cloudflare Pages connected to this repo, every push to `main` triggers a deploy.

- Build command: *(none)*
- Output directory: `/`

## Files

```
historical-figures-deploy/
├── index.html       # all CSS / JS / data inlined
├── README.md        # this file
└── photos/          # local portraits (optional; figures fall back to initial badges)
```

## Adding a new figure

Open `index.html`, find the `FIGURES_SEED = [` array, copy any existing entry
as a template, fill in:

- `id`, `name`, `nameZh`, `surname`, `given`
- `era`: one of `early-medieval | high-medieval | late-medieval | tudor`
- `role`: one of `monarch | poet | prose-author | chronicler | mystic | prelate | printer`
- `birthYear`, `deathYear`, `lifespan` (display string)
- `title` / `titleZh`, `affiliation` / `affiliationZh`
- `specialties` (tags array, 2–4 entries)
- `initials` (1–2 letters, used when no photo)
- `sourceUrl` (Wikipedia / Britannica / ODNB)
- `bio`, `works`, `events`, `relations`, `notes` (HTML strings — `<p>`, `<ul>`, `<div class='timeline'>`, `<a class='rellink' data-id='someone'>` cross-link)

Push to `main` and Cloudflare Pages rebuilds automatically.

## Why two sites?

`cf-deploy/` is the modern academic faculty directory (今日学者 in 中古英语方向).
`historical-figures-deploy/` is the historical counterpart — the 14th–16th c.
people the modern faculty actually study. The two share visual DNA on purpose.
