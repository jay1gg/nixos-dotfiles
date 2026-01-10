# Development Tools Setup

Your NixOS configuration now includes PHP, Node.js, and Python3 for full-stack development.

## 🚀 Quick Start

### PHP & Laravel

```bash
# Create a new Laravel project
composer create-project laravel/laravel my-app

# Navigate to project
cd my-app

# Run Laravel development server
php artisan serve

# Database migrations
php artisan migrate

# Run tests
php artisan test
```

**Installed:**
- PHP 8.4 with CLI
- Composer (PHP dependency manager)

### Node.js

```bash
# Check installed versions
node --version
npm --version
yarn --version
pnpm --version

# Create new project with your preferred package manager
npm init my-app
# or
pnpm create vite

# Install dependencies
npm install
# or
pnpm install

# Run development server
npm run dev

# Build for production
npm run build
```

**Installed:**
- Node.js 20 LTS
- npm (comes with Node)
- yarn (alternative package manager)
- pnpm (fast package manager)
- corepack (manages package manager versions)

**Development tools:**
- Prettier (code formatter)
- ESLint (JavaScript linter)
- TypeScript (type safety)

### Python 3

```bash
# Check Python version
python3 --version

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install packages
pip install package_name

# Format code
black my_file.py

# Run tests
pytest tests/

# Type checking
mypy my_file.py

# Linting
pylint my_file.py
```

**Installed:**
- Python 3 with pip
- virtualenv (create isolated environments)
- IPython (enhanced Python shell)
- ruff (fast linter)

**Development tools:**
- Black (code formatter)
- Pylint (linter)
- MyPy (static type checker)
- pytest (testing framework)

## 🛠️ Development Workflow

### Full-Stack Example (Laravel + Vue.js)

```bash
# 1. Create Laravel app
composer create-project laravel/laravel fullstack-app
cd fullstack-app

# 2. Install Node dependencies (including Vite + Vue)
npm install

# 3. Install Laravel packages for API
composer require laravel/sanctum
composer require barryvdh/laravel-cors

# 4. Run development servers (in separate terminals)
# Terminal 1 - Laravel backend
php artisan serve

# Terminal 2 - Vue frontend with Vite
npm run dev

# 5. Migrate database
php artisan migrate

# 6. Run tests
php artisan test
npm run test
```

### Python + Django Example

```bash
# 1. Create project directory
mkdir my-django-app
cd my-django-app

# 2. Create virtual environment
python3 -m venv venv
source venv/bin/activate

# 3. Install Django
pip install django

# 4. Create Django project
django-admin startproject myproject .

# 5. Run development server
python manage.py runserver

# 6. Create app and models
python manage.py startapp myapp

# 7. Run tests
python manage.py test
```

## 📦 Version Management

### Node.js Version Management

```bash
# Using corepack to manage package managers
corepack enable  # Enable corepack globally

# Switch package manager versions if needed
corepack prepare yarn@latest --activate
```

### Python Virtual Environments

```bash
# Create project-specific environment
python3 -m venv .venv
source .venv/bin/activate

# Deactivate when done
deactivate
```

## 🔧 System-Wide vs Project-Specific

All tools are installed **system-wide**, so they're available in any project directory without activation.

**For project isolation:**
- **PHP/Composer**: Use composer.lock file for version pinning
- **Node.js**: Use package-lock.json or pnpm-lock.yaml
- **Python**: Use virtual environments (.venv)

## 📚 Useful Commands

### Composer
```bash
composer install      # Install dependencies
composer update       # Update packages
composer require pkg  # Add new package
composer show         # List installed packages
```

### npm/pnpm/yarn
```bash
npm install           # Install dependencies
npm install -D pkg    # Install dev dependency
npm update            # Update packages
npm audit             # Check for vulnerabilities
npm list              # List installed packages
```

### Python
```bash
pip install pkg      # Install package
pip freeze           # Show installed packages
pip install -r req.txt # Install from requirements file
pip uninstall pkg    # Remove package
```

## 🐛 Troubleshooting

### PHP Artisan Issues
```bash
# Clear cache
php artisan cache:clear

# Regenerate app key
php artisan key:generate

# Clear config cache
php artisan config:clear
```

### Node.js Issues
```bash
# Clear npm cache
npm cache clean --force

# Reinstall node_modules
rm -rf node_modules package-lock.json
npm install

# Check for conflicting packages
npm audit fix --force
```

### Python Issues
```bash
# Upgrade pip
python3 -m pip install --upgrade pip

# Check Python path
which python3

# Verify installed packages
pip list
```

## 🚨 Notes

- All three languages are system-wide; no separate dev shells needed
- Versions are managed by nixpkgs (currently stable versions)
- For different version requirements per project, use per-project tools:
  - PHP: Different composer.json configurations
  - Node: .nvmrc or local node version managers
  - Python: Virtual environments

## 📖 Further Reading

- [PHP Documentation](https://www.php.net/manual/)
- [Laravel Documentation](https://laravel.com/docs)
- [Node.js Documentation](https://nodejs.org/docs/)
- [Python Documentation](https://docs.python.org/3/)
- [Python Virtual Environments](https://docs.python.org/3/tutorial/venv.html)
