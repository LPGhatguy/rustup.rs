#!/bin/sh

set -ex

rustc -vV
cargo -vV

cargo build --locked -v --release --target "$TARGET" --features vendored-openssl

if [ -z "$SKIP_TESTS" ]; then
  cargo run --locked --release --target "$TARGET" --features vendored-openssl -- --dump-testament
  cargo test --release -p download --target "$TARGET" --features vendored-openssl
  cargo test --release --target "$TARGET" --features vendored-openssl
fi
