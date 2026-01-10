{pkgs, ...}: {
  # Database client tools for general development
  
  environment.systemPackages = with pkgs; [
    # # PostgreSQL
    # postgresql # PostgreSQL client
    # pgadmin4-desktopmode # PostgreSQL GUI management
    
    # # MySQL / MariaDB
    # mariadb # MySQL/MariaDB client
    
    # # MongoDB
    # mongodb-compass # MongoDB GUI
    # mongosh # MongoDB shell
    
    # # Redis
    # redis # Redis client
    
    # # SQLite
    # sqlite # SQLite CLI
    
    # # Database utilities
    dbeaver # Universal database tool
    # sqlparse # SQL formatter/parser
  ];
}
