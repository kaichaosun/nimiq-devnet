# Nimiq DevNet Setup

A development network setup for running 4 Nimiq validators locally for testing and development purposes.

## Prerequisites

Before running the devnet, make sure you have the following installed:

- **tmux**: Terminal multiplexer for managing multiple validator sessions
  - macOS: `brew install tmux`
  - Ubuntu/Debian: `sudo apt-get install tmux`
  - CentOS/RHEL: `sudo yum install tmux`

- **Nimiq Client**: The setup script will automatically download the required Nimiq client binary (v1.2.1)

## Network Configuration

This devnet runs 4 validators with the following configuration:

| Validator | Port | RPC Port | Database Path |
|-----------|------|----------|---------------|
| Client 1  | 8443 | 8648     | `./tmp/.nimiq1` |
| Client 2  | 8445 | 8649     | `./tmp/.nimiq2` |
| Client 3  | 8446 | 8650     | `./tmp/.nimiq3` |
| Client 4  | 8447 | 8651     | `./tmp/.nimiq4` |

## Running the DevNet

You can run the devnet in two ways:

### Method 1: Automated Setup with tmux (Recommended)

This method automatically starts all 4 validators in a single tmux session:

```bash
./setup.sh
```

This will:
- Create a tmux session named `nimiq-validators`
- Start all 4 validators in separate tmux windows
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

### Method 2: Manual Setup (4 Separate Terminals)

Run each validator manually in separate terminal windows/tabs:

**Terminal 1 (Validator 1 - Seed Node):**
```bash
./run-validator.sh 1
```

**Terminal 2 (Validator 2):**
```bash
./run-validator.sh 2
```

**Terminal 3 (Validator 3):**
```bash
./run-validator.sh 3
```

**Terminal 4 (Validator 4):**
```bash
./run-validator.sh 4
```

## Accessing the Network

### RPC Endpoints

Each validator exposes a JSON-RPC interface:

- Validator 1: `http://127.0.0.1:8648`
- Validator 2: `http://127.0.0.1:8649`
- Validator 3: `http://127.0.0.1:8650`
- Validator 4: `http://127.0.0.1:8651`

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

## File Structure

```
.
├── README.md                 # This file
├── setup.sh                  # Automated tmux setup script
├── run-validator.sh           # Manual validator runner script
├── dev-albatross.toml         # Genesis configuration for devnet
├── validator1.toml            # Configuration for validator 1
├── validator2.toml            # Configuration for validator 2  
├── validator3.toml            # Configuration for validator 3
├── validator4.toml            # Configuration for validator 4
├── .nimiq-version            # Nimiq client version (v1.2.1)
├── keys/                     # Validator key files
│   ├── validator1
│   ├── validator2
│   ├── validator3
│   └── validator4
├── tmp/                      # Runtime data and databases
│   ├── .nimiq1/
│   ├── .nimiq2/
│   ├── .nimiq3/
│   └── .nimiq4/
├── bin/                      # Nimiq client binaries
└── scripts/                  # Helper scripts
```

## Troubleshooting

### Common Issues

1. **Port already in use**: Make sure no other processes are using ports 8443-8447 and 8648-8651
2. **Permission errors**: Ensure the scripts have execute permissions:
   ```bash
   chmod +x setup.sh run-validator.sh
   ```
3. **tmux not found**: Install tmux using your system's package manager
4. **Validators not connecting**: Make sure validator 1 is running before starting others

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
