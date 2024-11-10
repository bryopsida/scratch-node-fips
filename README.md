# Scratch Node Fips

## What is this?

An investigation into the practicality of using Node.JS with a scratch base layer.

## How?

Node.JS statically compiles a large portion of things but there are still a few libraries that are dynamiclly loaded at runtime. You can find these library files using `ldd`. The `shell.Dockerfile` was used to explore dependencies of binaries using `ldd` and then craft the `COPY` instructions for the dockerfile.

## Why?

Reduces attack surface to the absolute minimum by removing everything that's not required to function.

## What doesn't this cover?

### Packages that use node native addons

Node.JS also has `.node` files which are native compiled modules that can also link additional libraries. If you use any libraries that make use of libraries, you'll need to ensure those are copied over as well from your build layer. *Hint* you can find all .node files in your node_modules folder and run ldd checks.

### Packages that use shell executions

This intentionally does not have a shell. Any libraries that use shell executions for spawning will fail.

### Packages that use binaries that do not exist

This intentionally does not have common linux tools/binaries, if a library wraps a CLI tool you must copy that in along with any libraries it uses.

## How could this be further improved?

Ideally the needed libraries should be detected, copied into a folder tree in a intermediary layer, and then copied into the scratch layer.

## Tips

Remember that `.node` files can be dynamically compiled and/or pulled during `npm install`, and behavior can vary based on what arch is targetted. You'll want to inspect the `.node` files built/installed from a intermediary layer. Not your host machine.
