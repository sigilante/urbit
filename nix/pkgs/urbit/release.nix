{ env_name, env, deps }:

{
  ent,
  name ? "urbit",
  debug ? false,
  ge-additions,
  libaes_siv
}:

let

  crossdeps =
    with env;
    [ curl libgmp libsigsegv openssl zlib lmdb ];

  vendor =
    with deps;
    [ argon2 softfloat3 ed25519 ge-additions libaes_siv h2o scrypt uv murmur3 secp256k1 ivory-header ca-header ];

in

env.make_derivation {
  CFLAGS           = if debug then "-O0 -g" else "-O3 -g";
  # binary stripping disabled
  # LDFLAGS          = if debug then "" else "-s";
  MEMORY_DEBUG     = debug;
  CPU_DEBUG        = debug;
  EVENT_TIME_DEBUG = false;

  name              = "${name}-${env_name}";
  exename           = name;
  src               = ../../../pkg/urbit;
  cross_inputs      = crossdeps ++ vendor ++ [ ent ];
  builder           = ./release.sh;
}
