# PHP Development Environment
# Provides PHP 8.4 with Laravel development support
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    php84              # PHP 8.4 - Latest version with security updates
    php84Packages.composer  # Composer - PHP dependency manager (like npm/pip)
  ];

  # PHP environment configuration
  environment.variables = {
    PHP_VERSION = "84";  # Default PHP version reference
  };
}
