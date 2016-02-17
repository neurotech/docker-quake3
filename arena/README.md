# :rocket: Rocket Arena 3 Server on Alpine Linux

## Dependencies

 1. Docker
 2. A copy of the original Quake 3 `pak0.pk3`
 3. A copy of the Rocket Arena 3 (v1.76) mod `ra3176.zip`
 4. A `server.cfg` file containing your desired server configuration
 5. A `arena.cfg` file containing your desired RA3 configuration
 5. The following environment variables set:

| Variable    | Example Value         |
|-------------|-----------------------|
| `PAK0`      | `/path/to/pak0.pk3`   |
| `RA3`       | `/path/to/ra3176.zip` |
| `SERVERCFG` | `/path/to/server.cfg` |
| `ARENACFG` | `/path/to/arena.cfg`   |

## Build

```
./build.sh
```

## Run

```
./run.sh
```
