root := justfile_directory()
export TYPST_ROOT := root

[private]
default:
    @just --list --unsorted

# Generate manual
doc:
    typst compile docs/manual.typ docs/manual.pdf

# Run test suite
test *args:
    typst-test run {{ args }}

# Update test cases
update *args:
    typst-test update {{ args }}

# Package the library into the specified destination folder
package target:
    ./scripts/package "{{target}}"

# Install the library with the "@local" prefix
install: (package "@local")

# Install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
    ./scripts/uninstall "{{target}}"

# Uninstall the library from the "@local" prefix
uninstall: (remove "@local")

# Uninstall the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# Run CI suite
ci: test doc

# Compile main document
compile:
    typst compile main.typ main.pdf

# Watch main document for changes and recompile
watch:
    typst watch main.typ main.pdf

# Setup project (install dependencies, etc.)
setup:
    ./scripts/setup

# Clean generated files
clean:
    rm -f main.pdf docs/manual.pdf
    find . -name "*.pdf" -type f -delete

# Lint Typst files
lint:
    find . -name "*.typ" -type f -exec typst-fmt {} \;

# Generate thumbnails
thumbnails:
    convert -density 300 main.pdf -quality 90 thumbnails/%d.png

# Run all tests and generate documentation
all: test doc compile thumbnails

# Show project information
info:
    @echo "Project: Graceful Genetics"
    @echo "Root: {{root}}"
    @typst --version