#include <stdio.h>

unsigned long djb2(const char *str);

int main() {
    // Example usage of the hash function
    const char *str = "hii";
    unsigned long hash = djb2(str);
    printf("Hash of '%s' is %lu\n", str, hash);
    return 0;
}



unsigned long djb2(const char *str) {
    unsigned long hash = 5381;
    int c;

    while ((c = *str++)) {
        // hash * 33 + c
        hash = ((hash << 5) + hash) + c;
    }

    return hash;
}