# Cisco Secure Firewall Enablement Workshop

A [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/) recreation
of the Cisco Secure Firewall (FTD) Enablement Workshop.

## Local preview (optional)

Local tooling is **not** required — the site is built and hosted by GitHub Pages.
If you still want to preview locally, install the dependencies into a throwaway
virtual environment:

```bash
pip install -r requirements.txt
mkdocs serve
```

Then open <http://127.0.0.1:8000>.

## Build

```bash
mkdocs build
```

The static site is generated into the `site/` folder.

## Project layout

```text
docs/                          Markdown content
  index.md                     Home (Cisco dark-theme landing page, no images)
  overview.md
  prepare-lab.md
  lab-tasks.md
  theory.md
  deep-dive-diagnostics.md
  conclusion.md
  topologies.md
  stylesheets/extra.css        Cisco dark theme
  images/<section>/...         Screenshots grouped by menu / section
mkdocs.yml                     Site configuration
scripts/download-images.ps1    Re-downloads the source screenshots
.github/workflows/deploy.yml   Builds & deploys to GitHub Pages
```

## Refresh the screenshots

The lab screenshots are grouped under `docs/images/<section>/` by menu item and
section. To re-download them from the original site, run:

```powershell
pwsh ./scripts/download-images.ps1
```

## Deploy

This site is published with **GitHub Pages** and built entirely on GitHub — no
local tooling required. Every push to the `main` branch triggers the GitHub
Actions workflow (`.github/workflows/deploy.yml`), which installs the
dependencies, builds the site, and deploys it to GitHub Pages.

Live site: <https://ranilf2005.github.io/clmel26/>

The workflow enables GitHub Pages automatically. If the `github-pages`
environment is protected, approve the first deployment (or set
**Settings → Pages → Source** to **GitHub Actions**).
