# Nimiq DevNet Setup

A development network setup for running Nimiq validators locally for testing and development purposes.

## Prerequisites

Before running the devnet, make sure you have the following installed:

- **tmux**: Terminal multiplexer for managing multiple validator sessions
  - macOS: `brew install tmux`
  - Ubuntu/Debian: `sudo apt-get install tmux`
  - CentOS/RHEL: `sudo yum install tmux`

- **Nimiq Client**: The setup script will automatically download the required Nimiq client binary (v1.2.1)

## Network Configuration

This devnet runs validators with the following configuration:

| Validator | Port | RPC Port | Database Path |
|-----------|------|----------|---------------|
| Client 1  | 8443 | 8648     | `./tmp/.nimiq1` |
| Client 2  | 8445 | 8649     | `./tmp/.nimiq2` |
| Client 3  | 8446 | 8650     | `./tmp/.nimiq3` |
| Client 4  | 8447 | 8651     | `./tmp/.nimiq4` |

## Running the DevNet

You can run the devnet in two ways:

### Method 1: Automated Setup with tmux (Recommended)

This method automatically starts all validators in a single tmux session:

```bash
# clear old data
./clean.sh
```

```bash
./setup.sh
```

This will:
- Create a tmux session named `nimiq-validators`
- Start each validator in separate tmux windows
- Automatically connect clients

To attach to the tmux session and see the validators running:

```bash
tmux attach-session -t nimiq-validators
```

Navigate between validators using (the tmux prefix `Ctrl+b` could be different if you have customized it):
- `Ctrl+b` + `0` - Validator 1
- `Ctrl+b` + `1` - Validator 2  
- `Ctrl+b` + `2` - Validator 3
- `Ctrl+b` + `3` - Validator 4

To detach from the session (leave it running in background):
- `Ctrl+b` + `d`

To stop all validators and exit:

```bash
tmux kill-session -t nimiq-validators
```

### Method 2: Manual Setup (Separate Terminals)

Run each validator manually in separate terminal windows/tabs:

```bash
./run-validator.sh 1
```

```bash
./run-validator.sh 2
```

```bash
./run-validator.sh 3
```

```bash
./run-validator.sh 4
```

## Accessing the Network

### Example RPC Calls

```bash
# Get current block height
curl -X POST http://127.0.0.1:8648 \
  -H "Content-Type: application/json" \
  -d '{"method":"getBlockNumber","params":[],"id":1,"jsonrpc":"2.0"}'

# Get peer count
curl -X POST http://127.0.0.1:8648 \
  -H "Content-Type: application/json" \
  -d '{"method":"getPeerCount","params":[],"id":1,"jsonrpc":"2.0"}'
```

## Troubleshooting

### Common Issues

- **Port already in use**: Make sure no other processes are using ports 8443-8447 and 8648-8651
- **Permission errors**: Ensure the scripts have execute permissions:
   ```bash
   chmod +x setup.sh run-validator.sh
   ```
- **tmux not found**: Install tmux using your system's package manager
- **Validators not connecting**: Make sure validator 1 is running before starting others

### Logs and Debugging

- Logs are configured to `debug` level in all validator configurations
- Database files are stored in `./tmp/.nimiqN/` directories
- Each validator maintains its own database and key files

### Stopping the Network

- **tmux method**: `tmux kill-session -t nimiq-validators`
- **Manual method**: Use `Ctrl+C` in each terminal window

## Development

This devnet is configured for development and testing. All validators use:
- Development network mode (`dev-albatross`)
- Debug logging level
- Local loopback addresses
- Minimal peer connections for faster block times

The network starts from block 21600 with a predefined genesis state for consistent testing.
