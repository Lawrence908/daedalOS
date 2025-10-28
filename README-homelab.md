# daedalOS - Homelab Integration

## Overview

daedalOS is a desktop environment in the browser that provides a personal "Operating System" experience. It's been integrated into the Hephaestus Homelab infrastructure for use as a landing page and resource hub.

## Features

- **Desktop Environment**: Full desktop experience in the browser
- **File Management**: Built-in file browser and manager
- **Applications**: Various built-in applications and utilities
- **Customizable**: Can be customized with shortcuts to your homelab services
- **Responsive**: Works on desktop and mobile devices

## Homelab Integration

### Port Configuration
- **Direct Access**: `http://192.168.50.70:8158`
- **Public URL**: `https://chrislawrence.ca/os/`
- **Organizr Tab**: `http://192.168.50.70:8158` (for iframe embedding)

### Network Integration
- Connected to `homelab-web` network
- Accessible from other homelab services
- Proxy configuration in Caddy for public access

## Deployment

### Manual Deployment
```bash
cd /home/chris/apps/daedalOS
docker compose -f docker-compose-homelab.yml up -d
```

### Using Homelab Scripts
```bash
# Deploy with other apps
~/start-homelab.sh --category app

# Or deploy specifically
~/manage-services.sh up --service daedalos
```

### Health Check
```bash
# Check if daedalOS is running
curl -I http://192.168.50.70:8158

# Check logs
docker compose -f docker-compose-homelab.yml logs daedalos
```

## Configuration

### Docker Compose
The `docker-compose-homelab.yml` file includes:
- **Port**: 8158 (mapped to container port 3000)
- **Network**: homelab-web (external)
- **Health Check**: Built-in health monitoring
- **Restart Policy**: unless-stopped
- **Volume**: Persistent data storage

### Caddy Proxy
- **Public Route**: `/os/*` → `daedalos:3000`
- **Proxy Port**: `:8158` for Organizr embedding
- **Headers**: Frame-ancestors configured for embedding

## Customization

### Adding Homelab Services
You can customize daedalOS to include shortcuts to your homelab services:

1. **Access daedalOS**: `https://chrislawrence.ca/os/`
2. **Create Shortcuts**: Add desktop shortcuts to your services
3. **Customize Icons**: Use custom icons for your services
4. **Organize**: Create folders for different service categories

### Service Shortcuts
Example shortcuts you can add:
- **Portfolio**: `https://portfolio.chrislawrence.ca`
- **SchedShare**: `https://schedshare.chrislawrence.ca`
- **CapitolScope**: `https://capitolscope.chrislawrence.ca`
- **n8n**: `https://dev.chrislawrence.ca/n8n`
- **Portainer**: `https://dev.chrislawrence.ca/docker`
- **Grafana**: `https://dev.chrislawrence.ca/metrics`

## Monitoring

### Health Checks
```bash
# Check container status
docker compose -f docker-compose-homelab.yml ps

# Check health
curl -f http://192.168.50.70:8150 || echo "Service down"

# View logs
docker compose -f docker-compose-homelab.yml logs -f daedalos
```

### Integration with Homelab Monitoring
- **Uptime Kuma**: Monitor daedalOS availability
- **Grafana**: Track resource usage
- **Prometheus**: Collect metrics (if configured)

## Troubleshooting

### Common Issues

#### Service Not Starting
```bash
# Check logs
docker compose -f docker-compose-homelab.yml logs daedalos

# Check network
docker network inspect homelab-web

# Restart service
docker compose -f docker-compose-homelab.yml restart daedalos
```

#### Public Access Issues
```bash
# Check Caddy routing
curl -I https://chrislawrence.ca/os/

# Check proxy port
curl -I http://192.168.50.70:8158

# Check Caddy logs
docker compose -f /home/chris/github/hephaestus-homelab/proxy/docker-compose.yml logs caddy
```

#### Organizr Embedding Issues
```bash
# Check iframe headers
curl -I http://192.168.50.70:8158 | grep -i frame

# Test embedding
curl -I http://192.168.50.70:8158 | grep -i content-security
```

## Development

### Local Development
```bash
# Install dependencies
yarn install

# Start development server
yarn dev

# Build for production
yarn build
```

### Docker Development
```bash
# Build image
docker build -t daedalos .

# Run locally
docker run -p 3000:3000 daedalos
```

## Security

### Access Control
- **Public Access**: No authentication required for basic access
- **Organizr Integration**: Protected by Organizr authentication
- **Network Security**: Isolated in homelab-web network

### Headers
- **X-Frame-Options**: Removed for iframe embedding
- **Content-Security-Policy**: Configured for embedding
- **CORS**: Configured for cross-origin requests

## Backup

### Data Persistence
```bash
# Backup daedalOS data
docker run --rm -v daedalos_data:/data -v /backup:/backup alpine tar czf /backup/daedalos-backup-$(date +%Y%m%d).tar.gz -C /data .
```

### Configuration Backup
```bash
# Backup configuration
tar czf /backup/daedalos-config-$(date +%Y%m%d).tar.gz /home/chris/apps/daedalOS/
```

## Related Documentation

- [Homelab Applications](../docs/context/homelab/applications.md)
- [Service Status Tracker](../docs/context/homelab/services-status.md)
- [Deployment Guide](../docs/context/homelab/infra/deployment.md)
- [Network Architecture](../docs/context/homelab/infra/networks.md)

---

**Last Updated**: $(date)
**Version**: 1.0
**Status**: ✅ Ready for Deployment
