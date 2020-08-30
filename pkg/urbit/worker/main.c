/* worker/main.c
**
**  the main loop of a serf process.
*/
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <setjmp.h>
#include <gmp.h>
#include <sigsegv.h>
#include <stdint.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <uv.h>
#include <errno.h>

#include "all.h"
#include <vere/vere.h>
#include <vere/serf.h>

static u3_serf   u3V;             //  one serf per process
static u3_moat inn_u;             //  input stream
static u3_mojo out_u;             //  output stream

/* _cw_serf_fail(): failure stub.
*/
static void
_cw_serf_fail(void* vod_p, const c3_c* wut_c)
{
  fprintf(stderr, "serf: fail: %s\r\n", wut_c);
  exit(1);
}

/* _cw_serf_send(): send plea back to daemon.
*/
static void
_cw_serf_send(u3_noun pel)
{
  u3_newt_write(&out_u, u3ke_jam(pel));
}

/* _cw_serf_send_slog(): send hint output (hod is [priority tank]).
*/
static void
_cw_serf_send_slog(u3_noun hod)
{
  _cw_serf_send(u3nc(c3__slog, hod));
}

/* _cw_serf_send_stdr(): send stderr output
*/
static void
_cw_serf_send_stdr(c3_c* str_c)
{
  _cw_serf_send_slog(u3nc(0, u3i_string(str_c)));
}

/* _cw_serf_writ():
*/
static void
_cw_serf_writ(void* vod_p, u3_noun mat)
{
  u3_noun ret;

  if ( c3n == u3_serf_writ(&u3V, u3ke_cue(mat), &ret) ) {
    _cw_serf_fail(0, "bad jar");
  }
  else {
    _cw_serf_send(ret);

    //  all references must now be counted, and all roots recorded
    //
    u3_serf_post(&u3V);
  }
}

/* _cw_serf_stdio(): fix up std io handles
*/
static void
_cw_serf_stdio(c3_i* inn_i, c3_i* out_i)
{
  //  the serf is spawned with [FD 0] = events and [FD 1] = effects
  //  we dup [FD 0 & 1] so we don't accidently use them for something else
  //  we replace [FD 0] (stdin) with a fd pointing to /dev/null
  //  we replace [FD 1] (stdout) with a dup of [FD 2] (stderr)
  //
  c3_i nul_i = open("/dev/null", O_RDWR, 0);

  *inn_i = dup(0);
  *out_i = dup(1);

  dup2(nul_i, 0);
  dup2(2, 1);

  close(nul_i);
}

/* _cw_serf_commence(); initialize and run serf
*/
static void
_cw_serf_commence(c3_i argc, c3_c* argv[])
{
  c3_i inn_i, out_i;
  _cw_serf_stdio(&inn_i, &out_i);

  c3_assert( 7 == argc );

  uv_loop_t* lup_u = uv_default_loop();
  c3_c*      dir_c = argv[2];
  c3_c*      key_c = argv[3];
  c3_c*      wag_c = argv[4];
  c3_c*      hap_c = argv[5];
  c3_d       eve_d = 0;

  if ( 1 != sscanf(argv[6], "%" PRIu64 "", &eve_d) ) {
    fprintf(stderr, "serf: rock: invalid number '%s'\r\n", argv[4]);
  }

  memset(&u3V, 0, sizeof(u3V));
  memset(&u3_Host.tra_u, 0, sizeof(u3_Host.tra_u));

  //  load passkey
  //
  //    XX and then ... use passkey
  //
  {
    sscanf(key_c, "%" PRIx64 ":%" PRIx64 ":%" PRIx64 ":%" PRIx64 "",
                  &u3V.key_d[0],
                  &u3V.key_d[1],
                  &u3V.key_d[2],
                  &u3V.key_d[3]);
  }

  //  load runtime config
  //
  {
    sscanf(wag_c, "%" SCNu32, &u3C.wag_w);
    sscanf(hap_c, "%" SCNu32, &u3_Host.ops_u.hap_w);
  }

  //  Ignore SIGPIPE signals.
  //
  {
    struct sigaction sig_s = {{0}};
    sigemptyset(&(sig_s.sa_mask));
    sig_s.sa_handler = SIG_IGN;
    sigaction(SIGPIPE, &sig_s, 0);
  }

  //  configure pipe to daemon process
  //
  {
    c3_i err_i;

    err_i = uv_timer_init(lup_u, &inn_u.tim_u);
    c3_assert(!err_i);
    err_i = uv_pipe_init(lup_u, &inn_u.pyp_u, 0);
    c3_assert(!err_i);
    uv_pipe_open(&inn_u.pyp_u, inn_i);

    err_i = uv_pipe_init(lup_u, &out_u.pyp_u, 0);
    c3_assert(!err_i);
    uv_pipe_open(&out_u.pyp_u, out_i);

    uv_stream_set_blocking((uv_stream_t*)&out_u.pyp_u, 1);
  }

  //  set up writing
  //
  out_u.ptr_v = &u3V;
  out_u.bal_f = _cw_serf_fail;

  //  set up reading
  //
  inn_u.ptr_v = &u3V;
  inn_u.pok_f = _cw_serf_writ;
  inn_u.bal_f = _cw_serf_fail;

  //  setup loom
  //
  {
    u3V.dir_c = strdup(dir_c);
    u3V.sen_d = u3V.dun_d = u3m_boot(dir_c);

    if ( eve_d ) {
      u3_serf_uncram(&u3V, eve_d);
    }
  }

  //  set up logging
  //
  //    XX must be after u3m_boot due to u3l_log
  //
  {
    u3C.stderr_log_f = _cw_serf_send_stdr;
    u3C.slog_f = _cw_serf_send_slog;
  }

  //  start serf
  //
  {
    _cw_serf_send(u3_serf_init(&u3V));
  }

  //  start reading
  //
  u3_newt_read_sync(&inn_u);

  //  enter loop
  //
  uv_run(lup_u, UV_RUN_DEFAULT);
}

/* _cw_info(); print pier info
*/
static void
_cw_info(c3_i argc, c3_c* argv[])
{
  c3_assert( 3 <= argc );

  c3_c* dir_c = argv[2];
  c3_d  eve_d = u3m_boot(dir_c);

  fprintf(stderr, "urbit-worker: %s at event %" PRIu64 "\r\n", dir_c, eve_d);
}

/* _cw_grab(); gc pier.
*/
static void
_cw_grab(c3_i argc, c3_c* argv[])
{
  c3_assert( 3 <= argc );

  c3_c* dir_c = argv[2];
  u3m_boot(dir_c);
  u3_serf_grab();
}

/* _cw_cram(); jam persistent state (rock), and exit.
*/
static void
_cw_cram(c3_i argc, c3_c* argv[])
{
  c3_assert( 3 <= argc );

  c3_c* dir_c = argv[2];
  c3_d  eve_d = u3m_boot(dir_c);

  fprintf(stderr, "urbit-worker: cram: preparing\r\n");

  if ( c3n == u3m_rock_stay(dir_c, eve_d) ) {
    fprintf(stderr, "urbit-worker: cram: unable to jam state\r\n");
    exit(1);
  }

  fprintf(stderr, "urbit-worker: cram: rock saved at event %" PRIu64 "\r\n", eve_d);
}

/* _cw_queu(); cue rock, save, and exit.
*/
static void
_cw_queu(c3_i argc, c3_c* argv[])
{
  c3_assert( 4 <= argc );

  c3_c* dir_c = argv[2];
  c3_c* eve_c = argv[3];
  c3_d  eve_d;

  if ( 1 != sscanf(eve_c, "%" PRIu64 "", &eve_d) ) {
    fprintf(stderr, "urbit-worker: queu: invalid number '%s'\r\n", eve_c);
    exit(1);
  }
  else {
    fprintf(stderr, "urbit-worker: queu: preparing\r\n");

    memset(&u3V, 0, sizeof(u3V));
    u3V.dir_c = strdup(dir_c);
    u3V.sen_d = u3V.dun_d = u3m_boot(dir_c);
    u3_serf_uncram(&u3V, eve_d);
    u3e_save();

    fprintf(stderr, "urbit-worker: queu: rock loaded at event %" PRIu64 "\r\n", eve_d);
  }
}

/* _cw_pack(); compact memory, save, and exit.
*/
static void
_cw_pack(c3_i argc, c3_c* argv[])
{
  c3_assert( 3 <= argc );

  c3_c* dir_c = argv[2];

  u3m_boot(dir_c);
  u3a_print_memory(stderr, "urbit-worker: pack: gained", u3m_pack());

  u3e_save();
}

/* _cw_usage(): print urbit-worker usage.
*/
static void
_cw_usage(c3_i argc, c3_c* argv[])
{
  fprintf(stderr,
          "\rurbit-worker usage:\n"
          "  print pier info:\n"
          "    %s info <pier>\n\n"
          "  gc persistent state:\n"
          "    %s grab <pier>\n\n"
          "  compact persistent state:\n"
          "    %s pack <pier>\n\n"
          "  jam persistent state:\n"
          "    %s cram <pier>\n\n"
          "  cue persistent state:\n"
          "    %s queu <pier> <at-event>\n\n"
          "  run as a 'serf':\n"
          "    %s serf <pier> <key> <flags> <cache-size> <at-event>\n",
          argv[0], argv[0], argv[0], argv[0], argv[0], argv[0]);
}

/* main(): main() when run as urbit-worker
*/
c3_i
main(c3_i argc, c3_c* argv[])
{
  //  urbit-worker commands and positional arguments, by analogy
  //
  //    $@  ~               ;; usage
  //    $%  [%cram dir=@t]
  //        [%queu dir=@t eve=@ud]
  //        [%pack dir=@t]
  //        [%serf dir=@t key=@t wag=@t hap=@ud eve=@ud]
  //    ==
  //
  //    NB: don't print to anything other than stderr;
  //    other streams may have special requirements (in the case of "serf")
  //
  if ( 2 > argc ) {
    _cw_usage(argc, argv);
    exit(1);
  }
  else {
    if ( 0 == strcmp("serf", argv[1]) ) {
      _cw_serf_commence(argc, argv);
    }
    else if ( 0 == strcmp("info", argv[1]) ) {
      _cw_info(argc, argv);
    }
    else if ( 0 == strcmp("grab", argv[1]) ) {
      _cw_grab(argc, argv);
    }
    else if ( 0 == strcmp("cram", argv[1]) ) {
      _cw_cram(argc, argv);
    }
    else if ( 0 == strcmp("queu", argv[1]) ) {
      _cw_queu(argc, argv);
    }
    else if ( 0 == strcmp("pack", argv[1]) ) {
      _cw_pack(argc, argv);
    }
    else {
      fprintf(stderr, "unknown command '%s'\r\n", argv[1]);
      _cw_usage(argc, argv);
      exit(1);
    }
  }

  return 0;
}
