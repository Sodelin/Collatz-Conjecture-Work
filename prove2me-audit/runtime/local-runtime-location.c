/* Optional compatibility shim for the local hosted workspace.
 *
 * Lean 4.33.1 discovers its own executable using /proc/<pid>/exe. In this
 * workspace that query fails, although the executable path is already known.
 * This shim supplies that configured path. It does not access the restricted
 * path or modify arithmetic, elaboration, kernel checking, or proof terms.
 * Ordinary machines and GitHub CI do not need or use this file.
 */
#define _GNU_SOURCE
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dlfcn.h>

ssize_t readlink(const char *path, char *buffer, size_t size) {
    char own_executable[80];
    snprintf(own_executable, sizeof own_executable,
             "/proc/%ld/exe", (long)getpid());
    const char *configured = getenv("LEAN_APP_PATH");
    if (configured && strcmp(path, own_executable) == 0) {
        size_t length = strlen(configured);
        if (length > size) length = size;
        memcpy(buffer, configured, length);
        return (ssize_t)length;
    }
    ssize_t (*original)(const char *, char *, size_t) =
        dlsym(RTLD_NEXT, "readlink");
    return original(path, buffer, size);
}
