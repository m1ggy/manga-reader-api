#! /bin/bash

# Add env file
echo "NODE_ENV=PROD" >> .env
echo "PORT=3000" >> .env

# Install NVM
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

  # Load NVM
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

# Use Node version from .nvmrc
nvm install
nvm use

# Install project dependencies
npm install && npm update && npm cache clean --force

# Install PM2 globally if not installed
if ! command -v pm2 &> /dev/null; then
  echo "Installing PM2..."
  npm install -g pm2
fi

# Start the application with PM2
pm2 start npm  --name "reader-api" --env production -- start

# Optional: Set PM2 to auto-start on reboot
pm2 startup
pm2 save
