

int add(int x, int z) {
  return x+z;
}

int main(void) {
  int status = 0;

  for(int i=0; i < 5; i++) {
    status = add(status, i);
  }

  return status;
}

