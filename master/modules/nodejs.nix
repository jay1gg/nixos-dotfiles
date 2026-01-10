# Node.js Development Environment
# Provides Node.js LTS with package managers (npm, yarn, pnpm)
{config,pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nodejs_20        # Node.js 20 LTS - Long-term support version
    corepack         # Corepack - Manages yarn/pnpm/npm versions automatically
    pnpm             # PNPM - Fast, disk-efficient package manager (recommended)
    yarn             # Yarn - Alternative package manager (legacy support)
    # npm comes with Node.js by default
  ];
}
