# 1. Create the folders
mkdir -p microservices-demo/api-service
mkdir -p microservices-demo/data-service

# 2. Move into the project root — ALL commands after this run from here
cd microservices-demo

# 3. Create data-service files
cat > data-service/app.py << 'EOF'
...
EOF

cat > data-service/requirements.txt << 'EOF'
...
EOF

cat > data-service/Dockerfile << 'EOF'
...
EOF

# 4. Create api-service files
cat > api-service/app.py << 'EOF'
...
EOF

cat > api-service/requirements.txt << 'EOF'
...
EOF

cat > api-service/Dockerfile << 'EOF'
...
EOF

# 5. Create docker-compose.yml (also in microservices-demo/)
cat > docker-compose.yml << 'EOF'
...
EOF
