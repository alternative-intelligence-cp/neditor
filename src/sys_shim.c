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

#include <pthread.h>

static pthread_mutex_t queue_mtx = PTHREAD_MUTEX_INITIALIZER;
static int queue[256];
static int q_head = 0;
static int q_tail = 0;

void neditor_push_key(int key) {
    pthread_mutex_lock(&queue_mtx);
    int next = (q_tail + 1) % 256;
    if (next != q_head) {
        queue[q_tail] = key;
        q_tail = next;
    }
    pthread_mutex_unlock(&queue_mtx);
}

int neditor_pop_key(void) {
    int key = 0;
    pthread_mutex_lock(&queue_mtx);
    if (q_head != q_tail) {
        key = queue[q_head];
        q_head = (q_head + 1) % 256;
    }
    pthread_mutex_unlock(&queue_mtx);
    return key;
}
