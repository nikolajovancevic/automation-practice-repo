# automating-stuff-repo

this should not be pushed because checks have failed

App running on [link.](https://nikolajovancevic.github.io/automating-stuff/)


Add permission to script if needed

```
chmod +x [script-name]
```

### `deb-ubuntu-apps-setup.sh`

Script will install defined apps

### `test-exe.sh`

Example script for running different test groups through `CLI`.

Script that is being executed e.g. `smoke-test.sh` should accept 2 arguments, for example:

```
#! /bin/bash

ENV="$1" HEADLESS="$2" npm run test:smoke
```