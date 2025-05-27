
# Getting Started

**MiniSocket** is a lightweight, secure socket communication tool designed for encrypted data transfer with built-in protocol obfuscation. It's perfect for secure remote access, tunneling, and bypassing network restrictions.

---

## Core Concepts

- **Secret Key**: Shared secret for authentication (more secure than passwords)
- **Server**: Endpoint that listens for incoming connections (`mini-socket`)
- **Client**: Tool that connects to the server (`mini-nc`)
- **Port Forwarding**: Redirect traffic from one network port to another
- **Obfuscation**: Make traffic look like normal web traffic

---
## demo
![MiniSocket Demo](https://raw.githubusercontent.com/HaxorSecInfec/minisocket/refs/heads/main/example.gif)

## Basic Workflow

### 🖥️ On the Server

```bash
server@minisocket:~$ mini-socket -s mysecret
```

### 💻 On the Client

```bash
client@minisocket:~$ mini-nc -s mysecret
```

---

## 🚀 Installation

**MiniSocket** supports **Linux**, **macOS**, and **Windows (via WSL)**.

### Quick Install

```bash
$ bash -c "$(curl -fsSL https://minisocket.io/bin/x)"
```

#### With Custom Port

```bash
$ MINI_PORT=443 bash -c "$(curl -fsSL https://minisocket.io/bin/x)"
```

#### One-liner to Bypass Firewalls

```bash
$ curl -fsSLk -o ms https://minisocket.io/bin/mini-socket && chmod 755 ms && S=$(./ms -g) && MINI_PORT=443 MINI_ARGS="-s $S --daemon" ./ms && echo "Connect with: mini-nc -s $S"
```

> Installs both `mini-socket` (server) and `mini-nc` (client)

---

### Manual Installation

#### Server

```bash
$ wget -O /usr/bin/mini-socket https://minisocket.io/bin/mini-socket
$ chmod +x /usr/bin/mini-socket
```

#### Client

```bash
$ wget -O /usr/bin/mini-nc https://minisocket.io/bin/mini-nc
$ chmod +x /usr/bin/mini-nc
```

---

## 🛠 Server Usage

The `mini-socket` binary runs the server that listens for incoming connections.

### Server Options

```bash
Usage: mini-socket [OPTIONS]

Options:
  -s, --secret <secret>      # Set custom secret (required)
  -k, --keyfile <path>       # Load secret from file
  -g, --generate             # Generate random secret
  -p, --port <port>          # Listening port (default: 9000)
  -d, --daemon               # Run as daemon
  -v, --verbose              # Verbose output
  -h, --help                 # Show help
```

### Common Examples

```bash
# Basic server
$ mini-socket -s mysecret

# Custom port
$ mini-socket -s mysecret -p 443

# Daemon mode
$ mini-socket -s mysecret --daemon

# Using key file
$ echo "mysecret" > /etc/minisocket.key
$ mini-socket -k /etc/minisocket.key
```

### Environment Variables

| Variable     | Description         | Default |
|--------------|---------------------|---------|
| `MINI_PORT`  | Listening port      | 9000    |
| `MINI_ARGS`  | Additional arguments | None    |

---

## 🧑‍💻 Client Usage

The `mini-nc` binary connects to a MiniSocket server.

### Client Options

```bash
Usage: mini-nc [OPTIONS]

Options:
  -s, --secret <secret>     # Server secret (required)
  -i, --ip <address>        # Server IP (default: auto-detect)
  -p, --port <port>         # Server port (default: 9000)
  -h, --help                # Show help
```

### Common Examples

```bash
# Basic connection
$ mini-nc -s mysecret
[*] Connecting...
[+] Connected. Please enter to use
root@myserver:/#
```

```bash
# Help menu
$ mini-nc -h
```

---

## ⚙️ Configuration

MiniSocket supports configuration through CLI, environment variables, and config files.

---

## 🧾 Systemd Service

Create file: `/etc/systemd/system/minisocket.service`

```ini
[Unit]
Description=MiniSocket Secure Tunnel
After=network.target

[Service]
Type=simple
User=minisocket
ExecStart=/usr/bin/mini-socket -k /etc/minisocket.key --daemon
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

### Enable and Start Service

```bash
# systemctl daemon-reload
# systemctl enable --now minisocket
```

---

## 🔐 Security Features

- **AES-256 Encryption**: Military-grade secure comms
- **Key Rotation**: Every 60 seconds
- **Perfect Forward Secrecy**: Ephemeral session keys
- **HMAC Authentication**: Verifies message integrity

---

## 🛡️ Obfuscation Techniques

- **Protocol Mimicry**: Imitates HTTPS/WebSocket
- **Random Padding**: Prevents size analysis
- **Traffic Shaping**: Prevents timing analysis
- **Port Hopping**: Periodically changes port

---

## ✅ Best Practices

- Use long random secrets (min. 32 chars)
- Store secrets in permission-restricted files (chmod 600)
- Run as non-root user
- Use ports 443/80 to blend in with web traffic
- Rotate secrets regularly
- Monitor logs for anomalies

---

## 🧰 Troubleshooting

### ❗ Connection Timeout

**Cause**: Firewall, wrong port/IP, server down  
**Solution**: Verify server, check firewall, try ports `443`, `80`, `53`

### ❌ Authentication Failed

**Cause**: Secret mismatch, file permission  
**Solution**: Check both secrets, permissions `chmod 600`, no whitespace

### 🐌 High Latency

**Cause**: Network congestion, server load  
**Solution**: Try different ports, lower MTU, optimize routes

---

## 🔌 Join MiniSocket Network

🚀 **Join Now:**
- 🌐 Website: [minisocket.io](https://minisocket.io)
- 💬 Telegram Channel: [@minisocket](https://t.me/minisocket)

📞 **Contact Developer:**
- 👨‍💻 Telegram: [@ntKiL22](https://t.me/ntKiL22)


