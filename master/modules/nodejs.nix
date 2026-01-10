{pkgs, ...}: {
  # Node.js and npm/yarn
  environment.systemPackages = with pkgs; [
    nodejs_20 # Node.js LTS
    corepack # yarn, pnpm, npm version manager
    pnpm # Fast, disk space efficient package manager
    yarn # Alternative package manager
  ];

  # Global npm configuration directory
  environment.variables = {
    NODE_PATH = "\${HOME}/.npm";
  };
}
