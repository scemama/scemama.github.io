#ifdef __i386
double rdtsc_(void) {
  unsigned long long x;
  __asm__ volatile ("rdtsc" : "=A" (x));
  return (double) x;
}
#elif __amd64
double rdtsc_(void) {
  unsigned long long a, d;
  __asm__ volatile ("rdtsc" : "=a" (a), "=d" (d));
  return (double)((d<<32) | a);
}
#endif

