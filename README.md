Based on my exploration of the codebase, here's a detailed step-by-step guide to set up a local devnet:

  Prerequisites

  1. Rust toolchain with cargo installed
  2. Python >= 3.8 with dependencies:
    - jinja2 (template rendering)
    - tomli (TOML parsing)
  3. System tools: clang, cmake, libssl-dev, pkg-config

  Step-by-Step Setup

  Step 1: Navigate to the devnet scripts directory

  cd scripts/devnet

  Step 2: Create a topology file

  Create a TOML file defining your network. Example topology_sample.toml:

  [[validator]]
  restartable = true
  sync_mode = "history"

  [[validator]]
  restartable = true
  sync_mode = "history"

  [[validator]]
  restartable = true
  sync_mode = "history"

  [[validator]]
  restartable = true
  sync_mode = "history"

  [[seed]]
  restartable = false
  sync_mode = "history"

  Node options:
  - sync_mode: "full", "history", "light", or "pico"
  - restartable: Allow node restart during tests
  - enable_rpc: Enable JSON-RPC interface
  - enable_metrics: Enable metrics endpoint

  Step 3: Run the devnet

  Basic local devnet (release mode recommended for speed):
  python devnet.py -t topology_sample.toml --env local -R

  Generate configs only (dry run):
  python devnet.py -t topology_sample.toml --dry -o ./my-devnet

  Continuous mode (runs until error):
  python devnet.py -t topology_sample.toml -c --env local -R

  Step 4: Alternative - Docker Compose deployment

  python devnet.py -t topology_sample.toml --env docker-compose -o ./devnet-config
  cd ./devnet-config
  docker-compose up

  Key CLI Options
  ┌──────────────────┬───────────────────────────────────────────────┐
  │      Option      │                  Description                  │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ -t, --topology   │ TOML topology file (required)                 │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ -o, --output     │ Output directory (default: /tmp/nimiq-devnet) │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ -R, --release    │ Compile in release mode (faster)              │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ --env            │ Environment: local, docker-compose, or k8s    │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ -c, --continuous │ Run indefinitely                              │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ -m, --metrics    │ Enable metrics                                │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ -v               │ Increase verbosity (use multiple times)       │
  ├──────────────────┼───────────────────────────────────────────────┤
  │ --dry            │ Generate configs only, don't run              │
  └──────────────────┴───────────────────────────────────────────────┘
  Port Allocation (Local Environment)
  ┌───────────┬─────────────┬──────────┬──────────────┐
  │ Node Type │ Listen Port │ RPC Port │ Metrics Port │
  ├───────────┼─────────────┼──────────┼──────────────┤
  │ Seed      │ 9100+       │ 8100+    │ 9500+        │
  ├───────────┼─────────────┼──────────┼──────────────┤
  │ Validator │ 9200+       │ 8200+    │ 9600+        │
  ├───────────┼─────────────┼──────────┼──────────────┤
  │ Regular   │ 9300+       │ 8300+    │ 9700+        │
  ├───────────┼─────────────┼──────────┼──────────────┤
  │ Spammer   │ 9900+       │ 8900+    │ 9950+        │
  └───────────┴─────────────┴──────────┴──────────────┘
  Output Structure

  temp-logs/[timestamp]/
  ├── conf/
  │   ├── dev-albatross.toml      # Genesis file
  │   ├── validator1/client.toml  # Node configs
  │   └── seed1/client.toml
  └── validator1.log, seed1.log   # Node logs

  temp-state/[timestamp]/
  ├── validator1/
  │   ├── peer_key.dat
  │   ├── signing_key.dat
  │   ├── voting_key.dat
  │   └── devalbatross-history-consensus/  # Database

  What Happens When You Run

  1. Build phase: Compiles nodes with cargo
  2. Key generation: Creates BLS/Schnorr keypairs for validators
  3. Genesis generation: Creates genesis with validators and initial funds
  4. Startup: Seeds start first (3s delay), then other nodes (1s delay)
  5. Monitoring: Watches for panics, deadlocks, block production

  
  export NIMIQ_OVERRIDE_DEVNET_CONFIG=./dev-albatross.toml
