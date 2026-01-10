{pkgs, ...}: {
  # PHP with Laravel support
  environment.systemPackages = with pkgs; [
    php84 # PHP 8.4
    php84Packages.composer # Composer for PHP dependencies
  ];

  # PHP CLI tools and extensions
  environment.variables = {
    PHP_VERSION = "84";
  };
}
