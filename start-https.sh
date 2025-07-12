#!/bin/bash

echo "🚀 Starting HTTPS Docker setup..."
echo ""

# Check if SSL certificates exist
if [ ! -f "nginx/ssl/localhost.crt" ] || [ ! -f "nginx/ssl/localhost.key" ]; then
    echo "⚠️  SSL certificates not found. Generating them..."
    ./generate-ssl.sh
    echo ""
fi

# Build and start all services
echo "🔨 Building and starting all services..."
docker compose up --build

echo ""
echo "✅ Setup complete!"
echo ""
echo "🌐 Your application is now running on:"
echo "   Frontend: https://localhost:4443"
echo "   Backend API: https://localhost:4443/api"
echo ""
echo "⚠️  Note: You may see a security warning in your browser because we're using"
echo "   self-signed certificates. Click 'Advanced' -> 'Proceed to localhost' to continue."
