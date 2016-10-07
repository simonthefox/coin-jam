//
//  main.m
//  CoinJam
//
//  Created by Simon Mendoza on 4/11/16.
//
//

#import <Foundation/Foundation.h>
#import "primes.h"

typedef unsigned long long ull_t;

void findJamCoins(NSInteger N, NSInteger total);
void output(ull_t coin, ull_t *divisors);
void outputInBinary(ull_t n);

int main(int argc, const char * argv[]) {
    int cases = 0;
    int length = 0;
    int count = 0;
    
    scanf("%i", &cases);
    scanf("%i", &length);
    scanf("%i", &count);
    
    for (int i = 1; i<= cases; i++){
        printf("Case #%i:\n", i);
        findJamCoins(length, count);
    }
    return 0;
}

void findJamCoins(NSInteger N, NSInteger total) {
    NSInteger found = 0;
    ull_t maxc = (N==64)? ULLONG_MAX: pow(2, N)-1;
    ull_t S[11];
    for (ull_t coin = pow(2, N-1)+1; coin <= maxc; coin+=2) {
        memset(S, 0, 11*sizeof(ull_t));
        for (ull_t pi = 0; pi < 10; ++pi) {
            ull_t p = primes[pi];
            for (ull_t x = 0; x < p; ++x) {
                ull_t w = 1, q = 1, t = 1;
                ull_t c = coin;
                c >>= 1;
                while (c) {
                    w = (w*x) % p;
                    q = w*(c%2);
                    t = (t+q) % p;
                    c >>= 1;
                }
                if (t==0 && p!=coin) {
                    ull_t i = x;
                    while (i < 11) {
                        S[i] = p;
                        i += p;
                    }
                    if (S[2] && S[3] && S[4] && S[5] && S[6] && S[7] && S[8] && S[9] && S[10]) {
                        output(coin, S);
                        if (++found == total) return;
                        goto next;
                    }
                }
            }
        }
next:
        ;
    }
}

void output(ull_t coin, ull_t *divisors) {
    outputInBinary(coin);
    for (int d = 2; d < 11; ++d) {
        printf("%lld ", divisors[d]);
    }
    putc('\n', stdout);
}

void outputInBinary(ull_t n) {
    if (!n) printf("0 ");
    ull_t m = 1, a = n;
    while (a>>=1) ++m;
    char *os = (char*)calloc(m+1, sizeof(char));
    while (n) {
        os[--m] = (n%2)? '1': '0';
        n>>=1;
    }
    printf("%s ", os);
}
