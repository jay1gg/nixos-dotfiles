# Database tools and clients for development
{pkgs, ...}: {
  # System-wide database client tools
  # These tools allow connecting to various database servers for development/testing
  environment.systemPackages = with pkgs; [
    # PostgreSQL - Advanced open-source relational database
    # Uncomment to enable:
    # postgresql       # PostgreSQL command-line client
    # pgadmin4-desktopmode  # PostgreSQL web-based GUI management tool
    
    # MySQL/MariaDB - Popular open-source relational database
    # Uncomment to enable:
    # mariadb          # MySQL/MariaDB command-line client
    
    # MongoDB - Document-oriented NoSQL database
    # Uncomment to enable:
    # mongodb-compass  # MongoDB visual GUI client
    # mongosh          # MongoDB interactive shell
    
    # Redis - In-memory data structure store (caching, sessions, queues)
    # Uncomment to enable:
    # redis            # Redis CLI for development
    
    # SQLite - Lightweight embedded SQL database (single file)
    # Uncomment to enable:
    # sqlite           # SQLite command-line interface
    
    # Universal database tools (works with multiple databases)
    dbeaver-bin      # Multi-database GUI client (PostgreSQL, MySQL, MongoDB, SQLite, etc.)
    
    # SQL utilities
    # sqlparse         # Python SQL parser and formatter
  ];
}
