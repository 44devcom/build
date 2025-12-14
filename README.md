# Hacker theme demo — Jekyll development

This repository contains a minimal static demo of the GitHub Pages "Hacker" theme under `site/`.

If you want to render the remote theme locally with Jekyll, follow these steps.

Prerequisites
- Ruby (2.7+) and `bundler` installed on your machine or dev container.

Install dependencies
```bash
cd /workspaces/build
bundle install
```

Run the Jekyll dev server (serves the `site/` folder)
```bash
# from repo root; include the repository `_config.yml` so `baseurl` is applied
bundle exec jekyll serve --config _config.yml --source site --destination _site --port 8080 --host 0.0.0.0
```

Notes
- `_config.yml` enables `remote_theme: pages-themes/hacker`. The remote theme requires network access when Jekyll builds.
- For a minimal local preview without installing Jekyll, use the lightweight helper in `site/serve.sh`:
```bash
cd site
./serve.sh
```
- To expose the local server with Cloudflare Tunnel, run `bash t.sh` (Termux/cloudflared environment).

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
