#!/data/data/com.termux/files/usr/bin/bash
set -e

### CONFIG (EDIT IF NEEDED)
TUNNEL_NAME="z4u-mobile"
DOMAIN="z4u.fun"
LOCAL_SERVICE="http://localhost:8080"
ARCH="arm64"   # change to arm if needed

### COLORS
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${GREEN}== Cloudflared Termux Setup for $DOMAIN ==${NC}"

### 1. Update & install deps
echo "[1/8] Updating packages..."
pkg update -y
pkg install -y curl nano

### 2. Install cloudflared if missing
if ! command -v cloudflared >/dev/null 2>&1; then
  echo "[2/8] Installing cloudflared..."
  curl -L -o cloudflared \
    https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARCH
  chmod +x cloudflared
  mv cloudflared $PREFIX/bin/
else
  echo "[2/8] cloudflared already installed"
fi

cloudflared version

### 3. Login
echo "[3/8] Logging into Cloudflare..."
cloudflared tunnel login

### 4. Create tunnel (if not exists)
if ! cloudflared tunnel list | grep -q "$TUNNEL_NAME"; then
  echo "[4/8] Creating tunnel $TUNNEL_NAME..."
  cloudflared tunnel create "$TUNNEL_NAME"
else
  echo "[4/8] Tunnel already exists"
fi

### 5. Get tunnel UUID
TUNNEL_ID=$(cloudflared tunnel list | grep "$TUNNEL_NAME" | awk '{print $1}')
CRED_PATH="/data/data/com.termux/files/home/.cloudflared/$TUNNEL_ID.json"

if [ ! -f "$CRED_PATH" ]; then
  echo -e "${RED}ERROR: credentials file not found: $CRED_PATH${NC}"
  exit 1
fi

### 6. Create DNS route
echo "[5/8] Creating DNS route for $DOMAIN..."
cloudflared tunnel route dns "$TUNNEL_NAME" "$DOMAIN" || true

### 7. Create config.yml
echo "[6/8] Writing config.yml..."
mkdir -p ~/.cloudflared

cat > ~/.cloudflared/config.yml <<EOF
tunnel: $TUNNEL_NAME
credentials-file: $CRED_PATH

ingress:
  - hostname: $DOMAIN
    service: $LOCAL_SERVICE
  - service: http_status:404
EOF

### 8. Keep Termux alive & run tunnel
echo "[7/8] Preventing sleep kill..."
termux-wake-lock || true

echo "[8/8] Starting tunnel..."
echo -e "${GREEN}Tunnel running → https://$DOMAIN${NC}"
echo -e "${GREEN}DO NOT close Termux${NC}"

cloudflared tunnel run "$TUNNEL_NAME"
