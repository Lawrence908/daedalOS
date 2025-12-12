#!/usr/bin/env bash
set -Eeuo pipefail

# Test script for daedalOS deployment
echo "Testing daedalOS deployment..."

# Test 1: Check if docker-compose file exists
if [ ! -f "docker-compose-homelab.yml" ]; then
    echo "❌ docker-compose-homelab.yml not found"
    exit 1
fi
echo "✅ docker-compose-homelab.yml found"

# Test 2: Validate docker-compose syntax
if ! docker compose -f docker-compose-homelab.yml config >/dev/null 2>&1; then
    echo "❌ docker-compose syntax error"
    exit 1
fi
echo "✅ docker-compose syntax valid"

# Test 3: Check if Dockerfile exists
if [ ! -f "Dockerfile" ]; then
    echo "❌ Dockerfile not found"
    exit 1
fi
echo "✅ Dockerfile found"

# Test 4: Check if package.json exists
if [ ! -f "package.json" ]; then
    echo "❌ package.json not found"
    exit 1
fi
echo "✅ package.json found"

# Test 5: Check if yarn.lock exists
if [ ! -f "yarn.lock" ]; then
    echo "❌ yarn.lock not found"
    exit 1
fi
echo "✅ yarn.lock found"

echo ""
echo "🎉 All tests passed! daedalOS is ready for deployment."
echo ""
echo "To deploy daedalOS:"
echo "1. Run: cd /home/chris/apps/daedalOS"
echo "2. Run: docker compose -f docker-compose-homelab.yml up -d"
echo "3. Access at: http://192.168.50.128:8158"
echo "4. Public URL: https://chrislawrence.ca/os/"
echo "5. Organizr tab: http://192.168.50.128:8158"
