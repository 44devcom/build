
# Hacker theme demo — developer & deployment guide

Quick overview
- This repo demonstrates a GitHub Pages site based on the "Hacker" look-and-feel. Source content is in the `site/` folder; the generated static site is `_site/`.
- The repository contains both a vendored, local approximation of the theme (in `site/_layouts` and `site/_includes`) and `remote_theme: pages-themes/hacker` in `_config.yml`.

Prerequisites (local)
- Ruby (>= 3.0 recommended), Bundler, and network access if you use the remote theme.

Install and build locally
```bash
cd /workspaces/build
bundle install
# Build with the repository config so `baseurl` is applied
bundle exec jekyll build --config _config.yml --source site --destination _site --future
```

Preview locally
```bash
python3 -m http.server 8080 --directory _site
# open http://localhost:8080
```
Or use the lightweight helper (no Jekyll required):
```bash
cd site
./serve.sh
```

Notes about theme behavior
- Remote theme: `_config.yml` may include `remote_theme: pages-themes/hacker` and the `jekyll-remote-theme` plugin. When building, Jekyll will fetch the remote theme assets and layouts.
- Vendored theme: this repo also includes local `site/_layouts` and `site/_includes` so you can build and preview the exact layout offline. Local files take precedence over remote theme files.

CI / Auto-deploy
- Workflow: `.github/workflows/deploy.yml` builds the site and publishes `_site/` to the `gh-pages` branch using `peaceiris/actions-gh-pages`.
- The workflow runs `bundle install` and `bundle exec jekyll build --config _config.yml --source site --destination _site`, then publishes `_site` and verifies
	the Pages URL `https://44devcom.github.io/build/` responds with HTTP 200.

How deploy works (manual alternative)
- To publish without Actions: build into `docs/` and push `master` with `docs/` as Pages source, or push `_site/` contents to a `gh-pages` branch.

Common troubleshooting
- "Layout 'home' requested does not exist": happens locally if `jekyll-remote-theme` cannot fetch the remote theme. Use the vendored layouts or ensure network access and `bundle install` succeeded.
- 403/permission errors pushing from Actions: workflow needs `permissions: contents: write` and `pages: write` (already configured). If pushing fails, check repository-level Actions/Pages settings and `GITHUB_TOKEN` permissions.
- Missing posts: Jekyll ignores future-dated posts unless you pass `--future`.

Useful commands
- Dev build: `bundle exec jekyll build --config _config.yml --source site --destination _site --future`
- Dev server: `bundle exec jekyll serve --config _config.yml --source site --destination _site --port 8080`
- Quick preview: `python3 -m http.server 8080 --directory _site`

If you want, I can:
- remove the vendored theme and rely solely on `remote_theme` (requires network at build time),
- or vendor the complete Pages Hacker theme (copy remaining theme assets/layouts) so the repo is fully self-contained.

Questions or next steps? Tell me which option you prefer (remote-only vs fully vendored) and I’ll apply it.

CI / Auto-deploy
 - This repository includes a GitHub Actions workflow that builds the site and deploys the generated `_site` to the `gh-pages` branch on every push to `master`.
 - Workflow file: `.github/workflows/deploy.yml` — it runs `bundle install`, builds with `bundle exec jekyll build --source site --destination _site`, and uses `peaceiris/actions-gh-pages` to publish `_site`.
 - After the workflow runs, configure GitHub Pages in the repo Settings to serve from the `gh-pages` branch (root) if not already set. The action pushes to `gh-pages` automatically.

Local build vs CI
- Use the local `bundle exec jekyll build --config _config.yml --source site --destination _site` to verify output before pushing.

Notes about the remote theme
- This repo now uses the official GitHub Pages `pages-themes/hacker` remote theme via `remote_theme`.
- Building locally requires network access so Jekyll can fetch the remote theme. Use `bundle install` and run the build with the repository `_config.yml`:
```bash
bundle install
bundle exec jekyll build --config _config.yml --source site --destination _site --future
```
If you prefer to render fully offline, tell me and I will vendor the theme files into the `site/` directory.
 - If you'd rather not use Actions, you can publish manually by building into `docs/` or pushing `_site` to `gh-pages` (see README earlier for examples).

If you'd like, I can try running `bundle install` and a local `jekyll build` here to validate the workflow (I will need network access). If you prefer, I can also add a workflow that deploys to GitHub Pages and sets the Pages API configuration (requires a token).
# build — demo site

This repo contains a small static demo (in the `site/` folder) with a Hacker-style theme.

Develop locally with Jekyll (recommended for rendering the remote theme):

1. Install Ruby and Bundler (if not installed).
2. From the repo root run:

```bash
./dev.sh
```

This will run `bundle install` (using `Gemfile`) and then `bundle exec jekyll serve --source site`.

If you prefer a lightweight static server for quick checks (no Jekyll rendering):

```bash
cd site
./serve.sh
# or: python3 -m http.server 8080
```

To expose the locally served site via Cloudflare Tunnel (Termux-oriented script):

```bash
bash t.sh
```
