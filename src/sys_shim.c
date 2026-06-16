#include <signal.h>
#include <stddef.h>

static void sigwinch_handler(int sig) {
    (void)sig;
    // Dummy handler to interrupt blocking I/O
}

int neditor_hook_sigwinch(void) {
    struct sigaction sa;
    sa.sa_handler = sigwinch_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0; // NOT using SA_RESTART, so read() gets interrupted
    if (sigaction(SIGWINCH, &sa, NULL) < 0) {
        return -1;
    }
    return 0;
}
