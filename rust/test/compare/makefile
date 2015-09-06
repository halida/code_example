# cpp is almost double the speed of Rust
compare: build
	echo "testing rust speed"
	cd rust_compare; time cargo run
	echo "testing cpp speed"
	cd cpp_compare; time make run
build:
	cd rust_compare; cargo build
	cd cpp_compare; make build
